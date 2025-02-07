from http import HTTPStatus

from fast_zero.security import create_access_token, verify_password


def test_root_deve_retornar_ok_e_ola_mundo(client):
    response = client.get('/')

    assert response.status_code == HTTPStatus.OK
    assert response.json() == {'message': 'Olá Mundo!'}


def test_create_user_400_user_use(client, user):
    response = client.post(
        '/users/',
        json={
            'username': user.username,
            'email': 'alice@example.com',
            'password': 'secret',
        },
    )

    assert response.status_code == HTTPStatus.BAD_REQUEST
    assert response.json() == {'detail': 'Username already exists'}


def test_create_user_400_email_use(client, user):
    response = client.post(
        '/users/',
        json={
            'username': 'alice',
            'email': user.email,
            'password': 'secret',
        },
    )

    assert response.status_code == HTTPStatus.BAD_REQUEST
    assert response.json() == {'detail': 'Email already exists'}


def test_get_token(client, user):
    response = client.post(
        '/auth/token',
        data={'username': user.email, 'password': user.clean_password},
    )
    token = response.json()

    assert response.status_code == HTTPStatus.OK
    assert 'access_token' in token
    assert 'token_type' in token


def test_case_email_not_sent(client):
    data = {'no-email': 'test'}
    token = create_access_token(data)
    response = client.delete(
        '/users/1',
        headers={'Authorization': f'Bearer {token}'},
    )

    assert response.status_code == HTTPStatus.UNAUTHORIZED
    assert response.json() == {'detail': 'Could not validate credentials'}


def test_case_email_sent_dont_exist_user(client):
    data = {'sub': 'test'}
    token = create_access_token(data)

    response = client.delete(
        '/users/1',
        headers={'Authorization': f'Bearer {token}'},
    )

    assert response.status_code == HTTPStatus.UNAUTHORIZED
    assert response.json() == {'detail': 'Could not validate credentials'}


def test_delete_other_user_forbidden(client, another_user, token):
    response = client.delete(
        f'/users/{another_user.id}',
        headers={'Authorization': f'Bearer {token}'},
    )
    assert response.status_code == HTTPStatus.FORBIDDEN
    assert response.json()['detail'] == 'Not enouh permissions'


def test_update_user_conflict(client, user, another_user, token):
    response = client.put(
        f'/users/{user.id}',
        json={
            'username': another_user.username,
            'email': user.email,
            'password': 'newpassword',
        },
        headers={'Authorization': f'Bearer {token}'},
    )
    assert response.status_code == HTTPStatus.CONFLICT


def test_partial_update(client, user, token):
    response = client.put(
        f'/users/{user.id}',
        json={'email': 'new@email.com'},
        headers={'Authorization': f'Bearer {token}'},
    )
    assert response.status_code == HTTPStatus.OK
    assert response.json()['email'] == 'new@email.com'


def test_login_invalid_password(client, user):
    response = client.post(
        '/auth/token', data={'username': user.email, 'password': 'wrong'}
    )
    assert response.status_code == HTTPStatus.BAD_REQUEST
    assert response.json()['detail'] == 'Incorrect email or password'


def test_login_invalid_email(client):
    response = client.post(
        '/auth/token',
        data={'username': 'invalid@email.com', 'password': 'any'},
    )
    assert response.status_code == HTTPStatus.BAD_REQUEST


def test_update_password(client, user, token, session):
    new_password = 'newpass123'

    response = client.put(
        f'/users/{user.id}',
        json={'password': new_password},
        headers={'Authorization': f'Bearer {token}'},
    )
    assert response.status_code == HTTPStatus.OK

    session.refresh(user)

    assert verify_password(new_password, user.password)

    assert not verify_password('testtest', user.password)


def test_update_other_user(client, user, another_user, token):
    response = client.put(
        f'/users/{another_user.id}',
        json={
            'username': 'hacker',
            'email': 'hacker@test.com',
            'password': 'hack',
        },
        headers={'Authorization': f'Bearer {token}'},
    )
    assert response.status_code == HTTPStatus.FORBIDDEN
    assert response.json()['detail'] == 'Not enough permissions'

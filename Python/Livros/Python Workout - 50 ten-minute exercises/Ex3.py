def run_timing():
    soma = 0
    qtd = 0
    while True:
        run = input("Enter 10km run time (or press Enter to finish): ")
        if run == "":
            if qtd == 0:
                print("No runs entered.")
            else:
                average = soma / qtd
                print(f"Average of {average:.2f}, over {qtd} runs")
            break
        try:
            run = int(run)
        except ValueError:
            print("Please enter a valid number.")
            continue
        soma += run
        qtd += 1


run_timing()

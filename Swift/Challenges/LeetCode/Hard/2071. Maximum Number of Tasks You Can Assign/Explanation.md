## [PT/BR]

### O Problema

Temos `n` tarefas e `m` trabalhadores. Cada tarefa tem um requisito de força armazenado no array `tasks`, onde `tasks[i]` é a força necessária para completar a i-ésima tarefa. Cada trabalhador tem uma força armazenada no array `workers`, onde `workers[j]` é a força do j-ésimo trabalhador. Além disso, temos `pills` pílulas mágicas que podem aumentar a força de um trabalhador em `strength`. Cada trabalhador pode receber no máximo uma pílula.

Precisamos determinar o número máximo de tarefas que podem ser completadas, considerando que um trabalhador só pode ser designado para uma tarefa se sua força (com ou sem pílula) for maior ou igual ao requisito da tarefa.

### Raciocínio

1. **Ordenação**:
   - Ordenamos tanto as tarefas quanto os trabalhadores para facilitar a correspondência

2. **Busca Binária**:
   - Usamos busca binária para determinar o número máximo de tarefas que podem ser completadas
   - Para cada tentativa (mid), verificamos se é possível completar `mid` tarefas

3. **Alocação Ótima**:
   - Para cada tarefa, tentamos primeiro alocar o trabalhador mais forte possível sem usar pílula
   - Se não for possível, usamos uma pílula no trabalhador mais fraco que possa completar a tarefa com o reforço

4. **Busca Binária Auxiliar**:
   - Usamos busca binária para encontrar rapidamente o trabalhador mais fraco que possa completar a tarefa com o reforço da pílula

### Análise da Complexidade

- **Tempo**: O(n log n + m log m + log(min(n,m)) * (min(n,m) log m)) - Ordenação + Busca binária externa * Busca binária interna
- **Espaço**: O(min(n,m)) - Para armazenar os trabalhadores disponíveis

### Solução em Código

```swift
class Solution {
    func maxTaskAssign(_ tasks: [Int], _ workers: [Int], _ pills: Int, _ strength: Int) -> Int {
        let sortedTasks = tasks.sorted()
        let sortedWorkers = workers.sorted()
        var left = 0
        var right = min(tasks.count, workers.count)
        
        while left < right {
            let mid = (left + right + 1) / 2
            var usedPills = 0
            var availableWorkers = Array(sortedWorkers.suffix(mid))
            var canAssign = true
            
            for task in sortedTasks.prefix(mid).reversed() {
                if let last = availableWorkers.last, last >= task {
                    availableWorkers.removeLast()
                } else {
                    if let idx = findMinimumWorker(availableWorkers, task - strength) {
                        if usedPills == pills {
                            canAssign = false
                            break
                        }
                        usedPills += 1
                        availableWorkers.remove(at: idx)
                    } else {
                        canAssign = false
                        break
                    }
                }
            }
            
            if canAssign {
                left = mid
            } else {
                right = mid - 1
            }
        }
        
        return left
    }
    
    private func findMinimumWorker(_ workers: [Int], _ minStrength: Int) -> Int? {
        var low = 0
        var high = workers.count - 1
        var result: Int? = nil
        
        while low <= high {
            let mid = (low + high) / 2
            if workers[mid] >= minStrength {
                result = mid
                high = mid - 1
            } else {
                low = mid + 1
            }
        }
        
        return result
    }
}
```

### Exemplos

#### Exemplo 1:
**Input**: `tasks = [3,2,1]`, `workers = [0,3,3]`, `pills = 1`, `strength = 1`  
**Output**: `3`  
**Explicação**:
- Ordenado: tasks = [1,2,3], workers = [0,3,3]
- É possível completar todas as 3 tarefas usando 1 pílula no trabalhador mais fraco

#### Exemplo 2:
**Input**: `tasks = [5,4]`, `workers = [0,0,0]`, `pills = 1`, `strength = 5`  
**Output**: `1`  
**Explicação**:
- Só é possível completar 1 tarefa usando 1 pílula

#### Exemplo 3:
**Input**: `tasks = [10,15,30]`, `workers = [0,10,10,10,10]`, `pills = 3`, `strength = 10`  
**Output**: `2`  
**Explicação**:
- É possível completar 2 tarefas usando 2 pílulas

### Conclusão

Esta solução eficiente combina ordenação, busca binária e alocação gulosa para maximizar o número de tarefas completadas, considerando o uso estratégico das pílulas mágicas. A abordagem garante que encontremos a solução ótima de forma eficiente mesmo para grandes entradas.

---

## [EN]

### The Problem

We have `n` tasks and `m` workers. Each task has a strength requirement stored in array `tasks`, where `tasks[i]` is the strength needed to complete the ith task. Each worker has a strength stored in array `workers`, where `workers[j]` is the strength of the jth worker. Additionally, we have `pills` magical pills that can increase a worker's strength by `strength`. Each worker can receive at most one pill.

We need to determine the maximum number of tasks that can be completed, considering a worker can only be assigned to a task if their strength (with or without pill) is greater than or equal to the task's requirement.

### Reasoning

1. **Sorting**:
   - Sort both tasks and workers to facilitate matching

2. **Binary Search**:
   - Use binary search to determine the maximum number of completable tasks
   - For each attempt (mid), check if `mid` tasks can be completed

3. **Optimal Assignment**:
   - For each task, first try to assign the strongest possible worker without using a pill
   - If not possible, use a pill on the weakest worker that can complete the task with the boost

4. **Binary Search Helper**:
   - Use binary search to quickly find the weakest worker that can complete the task with pill boost

### Complexity Analysis

- **Time**: O(n log n + m log m + log(min(n,m)) * (min(n,m) log m)) - Sorting + Outer binary search * Inner binary search
- **Space**: O(min(n,m)) - To store available workers

### Code Solution

```swift
class Solution {
    func maxTaskAssign(_ tasks: [Int], _ workers: [Int], _ pills: Int, _ strength: Int) -> Int {
        let sortedTasks = tasks.sorted()
        let sortedWorkers = workers.sorted()
        var left = 0
        var right = min(tasks.count, workers.count)
        
        while left < right {
            let mid = (left + right + 1) / 2
            var usedPills = 0
            var availableWorkers = Array(sortedWorkers.suffix(mid))
            var canAssign = true
            
            for task in sortedTasks.prefix(mid).reversed() {
                if let last = availableWorkers.last, last >= task {
                    availableWorkers.removeLast()
                } else {
                    if let idx = findMinimumWorker(availableWorkers, task - strength) {
                        if usedPills == pills {
                            canAssign = false
                            break
                        }
                        usedPills += 1
                        availableWorkers.remove(at: idx)
                    } else {
                        canAssign = false
                        break
                    }
                }
            }
            
            if canAssign {
                left = mid
            } else {
                right = mid - 1
            }
        }
        
        return left
    }
    
    private func findMinimumWorker(_ workers: [Int], _ minStrength: Int) -> Int? {
        var low = 0
        var high = workers.count - 1
        var result: Int? = nil
        
        while low <= high {
            let mid = (low + high) / 2
            if workers[mid] >= minStrength {
                result = mid
                high = mid - 1
            } else {
                low = mid + 1
            }
        }
        
        return result
    }
}
```

### Examples

#### Example 1:
**Input**: `tasks = [3,2,1]`, `workers = [0,3,3]`, `pills = 1`, `strength = 1`  
**Output**: `3`  
**Explanation**:
- Sorted: tasks = [1,2,3], workers = [0,3,3]
- Can complete all 3 tasks using 1 pill on weakest worker

#### Example 2:
**Input**: `tasks = [5,4]`, `workers = [0,0,0]`, `pills = 1`, `strength = 5`  
**Output**: `1`  
**Explanation**:
- Can only complete 1 task using 1 pill

#### Example 3:
**Input**: `tasks = [10,15,30]`, `workers = [0,10,10,10,10]`, `pills = 3`, `strength = 10`  
**Output**: `2`  
**Explanation**:
- Can complete 2 tasks using 2 pills

### Conclusion

This efficient solution combines sorting, binary search and greedy assignment to maximize completed tasks, considering strategic use of magical pills. The approach ensures we find the optimal solution efficiently even for large inputs.
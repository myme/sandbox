#include <iostream>
#include <memory>
#include <string>


struct Node
{
    Node(int value)
        : value(value)
        , next(nullptr)
    {}

    int value;
    std::unique_ptr<Node> next;
};


class Stack
{
public:
    static std::unique_ptr<Stack> create()
    {
        return std::make_unique<Stack>();
    }

    Stack() : stack(nullptr) {}

    bool empty() const;
    size_t size() const;
    void push(int);
    int pop();

private:
    std::unique_ptr<Node> stack;
};


void Stack::push(int value)
{
    auto node = std::make_unique<Node>(value);
    std::swap(node, stack);
    if (node != nullptr) {
        stack->next = std::move(node);
    }
}

bool Stack::empty() const
{
    return stack == nullptr;
}

size_t Stack::size() const
{
    size_t size = 0;
    for (auto node = stack.get(); node != nullptr; node = node->next.get())
        ++size;
    return size;
}

int Stack::pop()
{
    auto node = std::move(stack->next);
    std::swap(node, stack);
    return node->value;
}

int main()
{
    auto stack = Stack::create();

    stack->push(42);
    stack->push(1337);
    // stack->pop();
    stack->push(1234567890);

    std::cout << "Stack size: " << stack->size() << std::endl;
    while (!stack->empty()) {
        std::cout << stack->pop() << std::endl;
    }

    stack.reset();
    return EXIT_SUCCESS;
}

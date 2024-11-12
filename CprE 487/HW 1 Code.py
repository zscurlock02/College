import numpy as np

# Sigmoid activation function
def sigmoid(z):
    return 1 / (1 + np.exp(-z))

# Derivative of sigmoid function
def sigmoid_derivative(z):
    return sigmoid(z) * (1 - sigmoid(z))

# Cross-entropy loss function
def cross_entropy_loss(y_true, y_pred):
    return -np.sum(y_true * np.log(y_pred) + (1 - y_true) * np.log(1 - y_pred))

# Initial weights and biases
wL0 = np.array([[0.1, 0.3, 0.4], 
                [0.2, 0.2, 0.1]])
bL0 = np.array([0.31416, -0.27182, 0.186282])

wL1 = np.array([[0.3, 0.1], 
                [0.5, 0.6], 
                [0.2, 0.7]])
bL1 = np.array([1.6180, 0.1729])

# Input and expected output
x = np.array([0.1, 0.7])
y_true = np.array([0, 1])

# Learning rate
learning_rate = 0.01

# Feedforward pass
# Input to hidden layer
zL0 = np.dot(x, wL0) + bL0
aL0 = sigmoid(zL0)

# Hidden to output layer
zL1 = np.dot(aL0, wL1) + bL1
aL1 = sigmoid(zL1)

# Compute loss
loss = cross_entropy_loss(y_true, aL1)
print("Loss:", loss)

# Backpropagation
# Error at output layer
deltaL1 = aL1 - y_true

# Gradient w.r.t. weights and biases (Hidden to Output)
grad_wL1 = np.outer(aL0, deltaL1)
grad_bL1 = deltaL1

# Error at hidden layer
deltaL0 = np.dot(deltaL1, wL1.T) * sigmoid_derivative(zL0)

# Gradient w.r.t. weights and biases (Input to Hidden)
grad_wL0 = np.outer(x, deltaL0)
grad_bL0 = deltaL0

# Update weights and biases
wL1_new = wL1 - learning_rate * grad_wL1
bL1_new = bL1 - learning_rate * grad_bL1

wL0_new = wL0 - learning_rate * grad_wL0
bL0_new = bL0 - learning_rate * grad_bL0

print("Updated wL0:", wL0_new)
print("Updated bL0:", bL0_new)
print("Updated wL1:", wL1_new)
print("Updated bL1:", bL1_new)

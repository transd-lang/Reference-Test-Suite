import time, math

def main():
	n = 200

	A = [[float(row) for row in range(n)] 
			for col in range(n)]
	B = [[float(n - row) for row in range(n)] 
			for col in range(n)]
	C = [[0 for row in range(n)] 
			for col in range(n)]

	st = time.time()

	for i in range(n):
		rowA = A[i]        # cache the row to increase performance
		rowC = C[i]
		for j in range(n):
			for k in range(n):
				rowC[j] += rowA[k] * B[k][j]

	en = time.time()
	print("Computation time was: %0.6f sec." % (en - st))

if __name__ == "__main__":
	main()


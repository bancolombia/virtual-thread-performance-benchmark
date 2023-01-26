package com.maocq.spring.domain.model.primes;

public class Primes {
    public static String primes (int N) {
        boolean[] isPrime = new boolean[N + 1];
        for (int i = 2; i <= N; i++)
            isPrime[i] = true;

        for (int i = 2; i*i <= N; i++)
        {
            if (isPrime[i])
            {
                for (int j = i; i*j <= N; j++)
                    isPrime[i*j] = false;
            }
        }

        StringBuilder builder = new StringBuilder();
        for (int i = 2; i <= N; i++)
        {
            if (isPrime[i])
                builder.append(i).append(" ");
        }
        return builder.toString();
    }
}

Comparison of gases between ERC721A, ERC721Oz(OppenZeppelin), ERC721Psi and ERC721Solmate

## Result

### Assuming a single mint

- mint:All except ERC721Oz are lined up.
- transfer:ERC721Psi has low gas costs.
- burn:ERC721Solmate has low gas costs.

| contract      | scenario |   mint | mintAverage | transferFromFirst | transferFromLast | burnFirst | burnLast |
| ------------- | -------- | -----: | ----------: | ----------------: | ---------------: | --------: | -------: |
| ERC721A       | mint1    |  47653 |       47653 |             28594 |                0 |     26325 |        0 |
| ERC721Oz      | mint1    | 137683 |      137683 |             53028 |                0 |      7401 |        0 |
| ERC721Psi     | mint1    |  48118 |       48118 |             15047 |                0 |     25957 |        0 |
| ERC721Solmate | mint1    |  47945 |       47945 |             28435 |                0 |      4203 |        0 |

### Assuming multiple mints

- mint:ERC721A and ERC721Psi have low gas costs.
- transfer:ERC721Solmate has low gas costs.
- burn:ERC721Solmate has low gas costs.

| contract      | scenario |    mint | mintAverage | transferFromFirst | transferFromLast | burnFirst | burnLast |
| ------------- | -------- | ------: | ----------: | ----------------: | ---------------: | --------: | -------: |
| ERC721A       | mint10   |   43347 |        4334 |             50991 |            46628 |     26325 |     4425 |
| ERC721Oz      | mint10   | 1149387 |      114938 |             53622 |            51622 |      7995 |     7401 |
| ERC721Psi     | mint10   |   45126 |        4512 |             37634 |            35314 |     25957 |     6057 |
| ERC721Solmate | mint10   |  251404 |       25140 |             28435 |             6535 |      4203 |     4203 |

### Conclusion

It is difficult to generalize as it varies depending on what kind of functionality is implemented, but

- If you want to create functional NFTs, ERC721Solmate may be the best choice.
- ERC721Psi may be the best choice for making PFP.

\*As expected, there was no difference in tokenId position.

Furthermore, I love ERC721A.

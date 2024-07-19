#include <iostream>
#include "myFuncs.h"

int main()
{
	std::cout << "Calling add function:\n";
	std::cout << "4 + 5 = " << addInts(4, 5) << '\n';

	std::cout << "Calling mult function:\n";
	std::cout << "4 * 5 = " << multInts(4, 5) << '\n';

	return 0;
}

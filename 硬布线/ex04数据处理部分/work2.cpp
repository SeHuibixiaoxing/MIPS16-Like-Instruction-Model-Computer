#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <iostream>
#include <cstring>
#include <fstream>

using namespace std;

string controlSignal[36];

string clock[4]; 

int main() {

	ifstream in("Ê±Ðò¿ØÖÆÐÅºÅcsv°æ.csv");
	string s;

	string T[4];
	T[0] = "(T0)";
	T[1] = "(T1)";
	T[2] = "(T2)";
	T[3] = "(T3)";
	string instruction[5][2];
	instruction[0][0] = "(!iB)";
	instruction[1][0] = "(!iC)";
	instruction[2][0] = "(!iD)";
	instruction[3][0] = "(!iE)";
	instruction[4][0] = "(!iF)";
	instruction[0][1] = "(iB)";
	instruction[1][1] = "(iC)";
	instruction[2][1] = "(iD)";
	instruction[3][1] = "(iE)";
	instruction[4][1] = "(iF)";

	clock[0] = clock[1] = clock[2] = clock[3] = "if(";

	while(getline(in, s)) {

		
		int p = 0;
		while(s[p] != ',') ++ p;
		
		int num = s[p + 1] - '0';
		
		int erjinzhi[5] = {0, 0, 0, 0, 0};
		-- p;
		int tot = 0;
		while(p >= 0) {
			erjinzhi[tot] = s[p] - '0';
			-- p;
			++ tot;
		}
	
		
		clock[num - 1] += "OP==5'b";
		
		clock[num - 1] += (char)(erjinzhi[4] + '0');
		clock[num - 1] += (char)(erjinzhi[3] + '0');
		clock[num - 1] += (char)(erjinzhi[2] + '0');
		clock[num - 1] += (char)(erjinzhi[1] + '0');
		clock[num - 1] += (char)(erjinzhi[0] + '0');

		clock[num - 1] += "||";

		
		for(int k = 0; k < num; ++ k) {

			getline(in, s);

			for(int i = 36 , j = 0; i >= 1; ++ j) {
				if(s[j] == ',') continue;
				-- i; 
				if(s[j] == '0') continue;

				controlSignal[i] += "(";
				controlSignal[i] += T[k] + "&&";
				for(int j = 0; j < 5; ++ j) {
					controlSignal[i] += instruction[j][erjinzhi[j]] + "&&";
				}
				controlSignal[i] += "(W1))||";
			}
		}

	}

	freopen("out2.txt", "w", stdout);
	cout << "control_singal[0] = " << controlSignal[0] << "0;" << std::endl;
	cout << "control_singal[1] = " << controlSignal[1] << "0;" << endl;
	cout << "control_singal[2] = " << controlSignal[2] << "((W0)&&(T1))||0;" << endl;
	cout << "control_singal[3] = " << controlSignal[3] << "((W0)&&(T0))||((W0)&&(T1))||((W0)&&(T2))||0;" << endl;
	cout << "control_singal[4] = " << controlSignal[4] << "((W0)&&(T0))||((W0)&&(T1))||((W0)&&(T2))||0;" << endl;
	cout << "control_singal[5] = " << controlSignal[5] << "((W0)&&(T0))||((W0)&&(T1))||((W0)&&(T2))||0;" << std::endl;
	cout << "control_singal[6] = " << controlSignal[6] << "((W0)&&(T0))||((W0)&&(T1))||((W0)&&(T2))||0;" << std::endl;
	cout << "control_singal[7] = " << controlSignal[7] << "0;" << std::endl;
	cout << "control_singal[8] = " << controlSignal[8] << "0;" << std::endl;
	cout << "control_singal[9] = " << controlSignal[9] << "0;" << std::endl;
	cout << "control_singal[10] = " << controlSignal[10] << "0;" << std::endl;
	cout << "control_singal[11] = " << controlSignal[11] << "0;" << std::endl;
	cout << "control_singal[12] = " << controlSignal[12] << "0;" << std::endl;
	cout << "control_singal[13] = " << controlSignal[13] << "((W0)&&(T0))||((W0)&&(T2))||0;" << std::endl;
	cout << "control_singal[14] = " << controlSignal[14] << "((W0)&&(T0))||((W0)&&(T1))||((W0)&&(T2))||0;" << std::endl;
	cout << "control_singal[15] = " << controlSignal[15] << "((W0)&&(T0))||((W0)&&(T2))||0;" << std::endl;
	cout << "control_singal[16] = " << controlSignal[16] << "0;" << std::endl;
	cout << "control_singal[17] = " << controlSignal[17] << "0;" << std::endl;
	cout << "control_singal[18] = " << controlSignal[18] << "0;" << std::endl;
	cout << "control_singal[19] = " << controlSignal[19] << "0;" << std::endl;
	cout << "control_singal[20] = " << controlSignal[20] << "0;" << std::endl;
	cout << "control_singal[21] = " << controlSignal[21] << "((W0)&&(T2))||0;" << std::endl;
	cout << "control_singal[22] = " << controlSignal[22] << "0;" << std::endl;
	cout << "control_singal[23] = " << controlSignal[23] << "0;" << std::endl;
	cout << "control_singal[24] = " << controlSignal[24] << "0;" << std::endl;
	cout << "control_singal[25] = " << controlSignal[25] << "((W0)&&(T0))||0;" << std::endl;
	cout << "control_singal[26] = " << controlSignal[26] << "1;" << std::endl;
	cout << "control_singal[27] = " << controlSignal[27] << "((W0)&&(T2))||0;" << std::endl;
	cout << "control_singal[28] = " << controlSignal[28] << "1;" << std::endl;
	cout << "control_singal[29] = " << controlSignal[29] << "((W0)&&(T1))||0;" << std::endl;
	cout << "control_singal[30] = " << controlSignal[30] << "0;" << std::endl;
	cout << "control_singal[31] = " << controlSignal[31] << "0;" << std::endl;
	cout << "control_singal[32] = " << controlSignal[32] << "0;" << std::endl;
	cout << "control_singal[33] = " << controlSignal[33] << "((W0)&&(T0))||((W0)&&(T1))||((W0)&&(T2))||0;" << std::endl;
	cout << "control_singal[34] = " << controlSignal[34] << "((W0)&&(T0))||((W0)&&(T1))||((W0)&&(T2))||0;" << std::endl;
	cout << "control_singal[35] = " << controlSignal[35] << "0;" << std::endl;

	cout << clock[0] << endl;
	cout << clock[1] << endl;
	cout << clock[2] << endl;
	cout << clock[3] << endl;
	
	return 0;
}




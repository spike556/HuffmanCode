/*******************************************************************
/*  Description:
/*            high-level model of huffman coding, written in C.
/*            it is a static huffman coding
/*            input data: 0 - 9
/*            totally  256 times
/*  Author:
/*            Guozhu Xin
/*  Date:
/*            2017/7/8
/*  Email contact:
/*            spikexin@outlook.com
*********************************************************************/
#include <iostream>
#include <string>
using namespace std;

struct HuffNode{
  int Value;                 // 0 - 9
  int Freq;                  // appear times
  HuffNode* LeftNode;
  HuffNode* RightNode;
};
struct HuffNode node[50];

void InitNode()
{
  node[0] = {0,5,NULL,NULL};
  node[1] = {1,10,NULL,NULL};
  node[2] = {2,15,NULL,NULL};
  node[3] = {3,20,NULL,NULL};
  node[4] = {4,25,NULL,NULL};
  node[5] = {5,30,NULL,NULL};
  node[6] = {6,35,NULL,NULL};
  node[7] = {7,40,NULL,NULL};
  node[8] = {8,45,NULL,NULL};
  node[9] = {9,31,NULL,NULL};
}


void SwitchNode(HuffNode* a, HuffNode* b)
{
  HuffNode temp;
  temp = *a;
  *a   = *b;
  *b   = temp;
}

void SortNode(int StartIdx, int len)
{
  if(len > 1){
    for(int i = StartIdx+len-1; i > StartIdx; i--){
      for(int j = StartIdx; j < i; j++){
        if(node[j].Freq > node[j+1].Freq){
          SwitchNode(&node[j], &node[j+1]);
        }
      }
    }
  }
}

HuffNode GenTree()
{
  int Len = 10;
  SortNode(0,Len);
  int StartIdx = 0,GenIdx = 10;
  while(Len > 1){
    Len --;
    StartIdx += 2;
    node[GenIdx++] = {-1,node[StartIdx-2].Freq+node[StartIdx-1].Freq,
                      &node[StartIdx-2],&node[StartIdx-1]};
    SortNode(StartIdx,Len);
  }
  return node[StartIdx];
}

void Traverse(HuffNode* node_ptr, string str)
{
  if(node_ptr->Value != -1){
    cout << node_ptr->Value << ": " << str << "\n";
  }
  else{
    str = str + '0';
    if(node_ptr->LeftNode){
      Traverse(node_ptr->LeftNode,str);
    }
    str[str.size()-1] = '1';
    if(node_ptr->RightNode){
      Traverse(node_ptr->RightNode,str);
    }
  }
}

int main()
{
  HuffNode  root;
  HuffNode* node_ptr;
  string str;
  InitNode();
  root = GenTree();
  node_ptr = &root;
  Traverse(node_ptr,str);
  return 0;
}

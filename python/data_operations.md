| operations             | list                             | dictionary                        | pd.Series                                 | pd.DataFrame                                       |
| ---------------------- | -------------------------------- | --------------------------------- | ----------------------------------------- | -------------------------------------------------- |
| Syntax                 | [1, 2, 3]                        | {'a':  1, 'b': 2}                 | pd.Series([1,2,3])                        | pd.DataFrame({'a':[1,2]})                          |
| For Loop Patterns      | for  x in lst:                   | for  k in dic:                    | for x in ser: output idx of ser           | for col in df:                                     |
|                        | for  i,k in enumerate(dic):      | for  i,x in ser.items():          | for i, row in df.iterrows():              | for i, row in df.iterrows():                       |
|                        | for  k,v in dic.items():         | for  idx, val in ser.items():     | for col, ser in df.items():               | for col, ser in df.items():                        |
|                        | for  k in dic.keys():            | for  val in ser.values:           | for val in df.values:                     | for val in df.values:                              |
|                        | for  v in dic.values():          | for  i,x in ser[ser>0].items():   | for i,row in df[df['a']>0].iterrows():    | for i,row in df[df['a']>0].iterrows():             |
|                        | for  k,v in dic.items() if v>0   | ser[ser>0]                        | df[df['a']>0]                             | df[df['a']>0]                                      |
| Create                 | lst  = [1, 2, 3]                 | dic  = {'a': 1}                   | pd.Series([1,2,3])                        | pd.DataFrame({'a':[1,2]})                          |
| Empty                  | [] or list()                     | {} or dict()                      | pd.Series()                               | pd.DataFrame()                                     |
| Access                 | lst[0]                           | dic['a']                          | ser[0] or ser.loc['a']                    | df['col'] or df.loc[0]                             |
| Slice                  | lst[1:3]                         | Not supported                     | ser[1:3]                                  | df[1:3] or df.loc[1:3]                             |
| Length                 | len(lst)                         | len(dic)                          | len(ser), ser.shape, ser.index            | len(df), df.shape, df.columns, df.index            |
| Add                    | lst.append(x)                    | dic[k]  = v                       | ser[idx]  = val                           | df['new']  = values                                |
| Insert                 | lst.insert(i, x)                 | dic.setdefault(k, v)              | ser.insert(i, idx, val)                   | df.insert(i, 'col', values)                        |
| Extend                 | lst.extend([x,y])                | dic.update({k:v})                 | ser.append(ser2)                          | pd.concat([df1,  df2])                             |
| Concat                 | lst1 + lst2                      | {\*\*d1,  \*\*d2}                 | pd.concat([s1,  s2])                      | pd.concat([df1,  df2])                             |
| Remove                 | lst.remove(x)                    | del  dic[k]                       | ser.drop(idx)                             | df.drop('col',  axis=1)                            |
| Pop                    | lst.pop()                        | dic.pop(k)                        | Not supported                             | df.pop('col')                                      |
| Clear                  | lst.clear()                      | dic.clear()                       | ser.drop(ser.index)                       | df.drop(df.index)                                  |
| Delete                 | del  lst[i]                      | dic.pop(k,  default)              | del ser[idx] or ser.dropna()              | del df['col'] or  df.dropna()                      |
| Contains               | x  in lst                        | k  in dic                         | val in ser.values                         | 'col' in df.columns                                |
| Index                  | lst.index(x)                     | dic.keys()                        | ser.index                                 | df.index                                           |
| Count                  | lst.count(x)                     | len(dic)                          | ser.value_counts()                        | df['col'].value_counts()                           |
| Min/Max                | min(lst)                         | min(dic)                          | ser.min(), ser.max()                      | df.min(), df.max()                                 |
| Sum/Mean               | sum(lst)                         | Not supported                     | ser.sum(), ser.mean()                     | df.sum(), df.mean()                                |
| Sort                   | lst.sort()                       | sorted(dic)                       | ser.sort_values()                         | df.sort_values('col')                              |
| Reverse                | lst.reverse()                    | Not supported                     | ser[::-1]                                 | df.iloc[::-1]                                      |
| Copy                   | lst.copy()                       | dic.copy()                        | ser.copy()                                | df.copy()                                          |
| Unique                 | list(set(lst))                   | Not supported                     | ser.unique()                              | df['col'].unique()                                 |
| Apply                  | map(fn,  lst)                    | map(fn,  dic)                     | ser.apply(fn)                             | df.apply(fn)                                       |

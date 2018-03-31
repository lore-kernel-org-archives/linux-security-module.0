From: fengguang.wu@intel.com (kbuild test robot)
Date: Sat, 31 Mar 2018 15:41:31 +0800
Subject: [security:next-testing 16/17] include/linux/list.h:377:18: error:
	'struct hlist_head' has no member named 'next'
Message-ID: <201803311519.CBdbidaz%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-testing
head:   3f3122c1b84c8f60a89184f2b0d854ffd89c7534
commit: 22402b0b736d513caf74fce1bbeb579268530599 [16/17] security: convert security hooks to use hlist
config: sh-allmodconfig (attached as .config)
compiler: sh4-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 22402b0b736d513caf74fce1bbeb579268530599
        # save the attached .config to linux build tree
        make.cross ARCH=sh 

Note: the security/next-testing HEAD 3f3122c1b84c8f60a89184f2b0d854ffd89c7534 builds fine.
      It only hurts bisectibility.

All error/warnings (new ones prefixed by >>):

   security/security.c: In function 'security_add_hooks':
>> security/security.c:166:21: error: passing argument 1 of 'list_add_tail_rcu' from incompatible pointer type [-Werror=incompatible-pointer-types]
      list_add_tail_rcu(&hooks[i].list, hooks[i].head);
                        ^
   In file included from include/linux/dcache.h:7:0,
                    from security/security.c:17:
   include/linux/rculist.h:98:20: note: expected 'struct list_head *' but argument is of type 'struct hlist_node *'
    static inline void list_add_tail_rcu(struct list_head *new,
                       ^~~~~~~~~~~~~~~~~
   security/security.c:166:37: error: passing argument 2 of 'list_add_tail_rcu' from incompatible pointer type [-Werror=incompatible-pointer-types]
      list_add_tail_rcu(&hooks[i].list, hooks[i].head);
                                        ^~~~~
   In file included from include/linux/dcache.h:7:0,
                    from security/security.c:17:
   include/linux/rculist.h:98:20: note: expected 'struct list_head *' but argument is of type 'struct hlist_head *'
    static inline void list_add_tail_rcu(struct list_head *new,
                       ^~~~~~~~~~~~~~~~~
   In file included from include/linux/list.h:9:0,
                    from include/linux/timer.h:5,
                    from include/linux/workqueue.h:9,
                    from include/linux/bpf.h:12,
                    from security/security.c:15:
   security/security.c: In function 'security_binder_set_context_mgr':
>> include/linux/list.h:377:18: error: 'struct hlist_head' has no member named 'next'
     list_entry((ptr)->next, type, member)
                     ^
   include/linux/kernel.h:947:26: note: in definition of macro 'container_of'
     void *__mptr = (void *)(ptr);     \
                             ^~~
   include/linux/list.h:377:2: note: in expansion of macro 'list_entry'
     list_entry((ptr)->next, type, member)
     ^~~~~~~~~~
   include/linux/list.h:464:13: note: in expansion of macro 'list_first_entry'
     for (pos = list_first_entry(head, typeof(*pos), member); \
                ^~~~~~~~~~~~~~~~
>> security/security.c:213:3: note: in expansion of macro 'list_for_each_entry'
      list_for_each_entry(P, &security_hook_heads.FUNC, list) { \
      ^~~~~~~~~~~~~~~~~~~
   security/security.c:226:9: note: in expansion of macro 'call_int_hook'
     return call_int_hook(binder_set_context_mgr, 0, mgr);
            ^~~~~~~~~~~~~
   In file included from include/linux/kernel.h:10:0,
                    from include/linux/list.h:9,
                    from include/linux/timer.h:5,
                    from include/linux/workqueue.h:9,
                    from include/linux/bpf.h:12,
                    from security/security.c:15:
>> include/linux/list.h:377:18: error: 'struct hlist_head' has no member named 'next'
     list_entry((ptr)->next, type, member)
                     ^
   include/linux/compiler.h:316:19: note: in definition of macro '__compiletime_assert'
      bool __cond = !(condition);    \
                      ^~~~~~~~~
   include/linux/compiler.h:339:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:45:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:948:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
     ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:948:20: note: in expansion of macro '__same_type'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
                       ^~~~~~~~~~~
   include/linux/list.h:366:2: note: in expansion of macro 'container_of'
     container_of(ptr, type, member)
     ^~~~~~~~~~~~
   include/linux/list.h:377:2: note: in expansion of macro 'list_entry'
     list_entry((ptr)->next, type, member)
     ^~~~~~~~~~
   include/linux/list.h:464:13: note: in expansion of macro 'list_first_entry'
     for (pos = list_first_entry(head, typeof(*pos), member); \
                ^~~~~~~~~~~~~~~~
>> security/security.c:213:3: note: in expansion of macro 'list_for_each_entry'
      list_for_each_entry(P, &security_hook_heads.FUNC, list) { \
      ^~~~~~~~~~~~~~~~~~~
   security/security.c:226:9: note: in expansion of macro 'call_int_hook'
     return call_int_hook(binder_set_context_mgr, 0, mgr);
            ^~~~~~~~~~~~~
>> include/linux/list.h:377:18: error: 'struct hlist_head' has no member named 'next'
     list_entry((ptr)->next, type, member)
                     ^
   include/linux/compiler.h:316:19: note: in definition of macro '__compiletime_assert'
      bool __cond = !(condition);    \
                      ^~~~~~~~~
   include/linux/compiler.h:339:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:45:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:948:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
     ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:949:6: note: in expansion of macro '__same_type'
        !__same_type(*(ptr), void),   \
         ^~~~~~~~~~~
   include/linux/list.h:366:2: note: in expansion of macro 'container_of'
     container_of(ptr, type, member)
     ^~~~~~~~~~~~
   include/linux/list.h:377:2: note: in expansion of macro 'list_entry'
     list_entry((ptr)->next, type, member)
     ^~~~~~~~~~
   include/linux/list.h:464:13: note: in expansion of macro 'list_first_entry'
     for (pos = list_first_entry(head, typeof(*pos), member); \
                ^~~~~~~~~~~~~~~~
>> security/security.c:213:3: note: in expansion of macro 'list_for_each_entry'
      list_for_each_entry(P, &security_hook_heads.FUNC, list) { \
      ^~~~~~~~~~~~~~~~~~~
   security/security.c:226:9: note: in expansion of macro 'call_int_hook'
     return call_int_hook(binder_set_context_mgr, 0, mgr);
            ^~~~~~~~~~~~~
   In file included from include/linux/timer.h:5:0,
                    from include/linux/workqueue.h:9,
                    from include/linux/bpf.h:12,
                    from security/security.c:15:
   include/linux/list.h:465:20: warning: comparison of distinct pointer types lacks a cast
          &pos->member != (head);     \
                       ^
>> security/security.c:213:3: note: in expansion of macro 'list_for_each_entry'
      list_for_each_entry(P, &security_hook_heads.FUNC, list) { \
      ^~~~~~~~~~~~~~~~~~~
   security/security.c:226:9: note: in expansion of macro 'call_int_hook'
     return call_int_hook(binder_set_context_mgr, 0, mgr);
            ^~~~~~~~~~~~~
   In file included from include/linux/list.h:9:0,
                    from include/linux/timer.h:5,
                    from include/linux/workqueue.h:9,
                    from include/linux/bpf.h:12,
                    from security/security.c:15:
   security/security.c: In function 'security_binder_transaction':
>> include/linux/list.h:377:18: error: 'struct hlist_head' has no member named 'next'
     list_entry((ptr)->next, type, member)
                     ^
   include/linux/kernel.h:947:26: note: in definition of macro 'container_of'
     void *__mptr = (void *)(ptr);     \
                             ^~~
   include/linux/list.h:377:2: note: in expansion of macro 'list_entry'
     list_entry((ptr)->next, type, member)
     ^~~~~~~~~~
   include/linux/list.h:464:13: note: in expansion of macro 'list_first_entry'
     for (pos = list_first_entry(head, typeof(*pos), member); \
                ^~~~~~~~~~~~~~~~
>> security/security.c:213:3: note: in expansion of macro 'list_for_each_entry'
      list_for_each_entry(P, &security_hook_heads.FUNC, list) { \
      ^~~~~~~~~~~~~~~~~~~
   security/security.c:232:9: note: in expansion of macro 'call_int_hook'
     return call_int_hook(binder_transaction, 0, from, to);
            ^~~~~~~~~~~~~
   In file included from include/linux/kernel.h:10:0,
                    from include/linux/list.h:9,
                    from include/linux/timer.h:5,
                    from include/linux/workqueue.h:9,
                    from include/linux/bpf.h:12,
                    from security/security.c:15:
>> include/linux/list.h:377:18: error: 'struct hlist_head' has no member named 'next'
     list_entry((ptr)->next, type, member)
                     ^
   include/linux/compiler.h:316:19: note: in definition of macro '__compiletime_assert'
      bool __cond = !(condition);    \
                      ^~~~~~~~~
   include/linux/compiler.h:339:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:45:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:948:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
     ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:948:20: note: in expansion of macro '__same_type'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
                       ^~~~~~~~~~~
   include/linux/list.h:366:2: note: in expansion of macro 'container_of'
     container_of(ptr, type, member)
     ^~~~~~~~~~~~
   include/linux/list.h:377:2: note: in expansion of macro 'list_entry'
     list_entry((ptr)->next, type, member)
     ^~~~~~~~~~
   include/linux/list.h:464:13: note: in expansion of macro 'list_first_entry'
     for (pos = list_first_entry(head, typeof(*pos), member); \
                ^~~~~~~~~~~~~~~~
>> security/security.c:213:3: note: in expansion of macro 'list_for_each_entry'
      list_for_each_entry(P, &security_hook_heads.FUNC, list) { \
      ^~~~~~~~~~~~~~~~~~~
   security/security.c:232:9: note: in expansion of macro 'call_int_hook'
     return call_int_hook(binder_transaction, 0, from, to);
            ^~~~~~~~~~~~~
>> include/linux/list.h:377:18: error: 'struct hlist_head' has no member named 'next'
     list_entry((ptr)->next, type, member)
                     ^
   include/linux/compiler.h:316:19: note: in definition of macro '__compiletime_assert'
      bool __cond = !(condition);    \
                      ^~~~~~~~~
   include/linux/compiler.h:339:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:45:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:948:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
     ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:949:6: note: in expansion of macro '__same_type'
        !__same_type(*(ptr), void),   \
         ^~~~~~~~~~~
   include/linux/list.h:366:2: note: in expansion of macro 'container_of'
     container_of(ptr, type, member)
     ^~~~~~~~~~~~
   include/linux/list.h:377:2: note: in expansion of macro 'list_entry'
     list_entry((ptr)->next, type, member)
     ^~~~~~~~~~
   include/linux/list.h:464:13: note: in expansion of macro 'list_first_entry'
     for (pos = list_first_entry(head, typeof(*pos), member); \
                ^~~~~~~~~~~~~~~~
>> security/security.c:213:3: note: in expansion of macro 'list_for_each_entry'
      list_for_each_entry(P, &security_hook_heads.FUNC, list) { \
      ^~~~~~~~~~~~~~~~~~~
   security/security.c:232:9: note: in expansion of macro 'call_int_hook'
     return call_int_hook(binder_transaction, 0, from, to);
            ^~~~~~~~~~~~~
   In file included from include/linux/timer.h:5:0,
                    from include/linux/workqueue.h:9,
                    from include/linux/bpf.h:12,
                    from security/security.c:15:
   include/linux/list.h:465:20: warning: comparison of distinct pointer types lacks a cast
          &pos->member != (head);     \
                       ^
>> security/security.c:213:3: note: in expansion of macro 'list_for_each_entry'
      list_for_each_entry(P, &security_hook_heads.FUNC, list) { \
      ^~~~~~~~~~~~~~~~~~~
   security/security.c:232:9: note: in expansion of macro 'call_int_hook'
     return call_int_hook(binder_transaction, 0, from, to);
            ^~~~~~~~~~~~~
   In file included from include/linux/list.h:9:0,
                    from include/linux/timer.h:5,
                    from include/linux/workqueue.h:9,
                    from include/linux/bpf.h:12,
                    from security/security.c:15:
   security/security.c: In function 'security_binder_transfer_binder':
>> include/linux/list.h:377:18: error: 'struct hlist_head' has no member named 'next'
     list_entry((ptr)->next, type, member)
                     ^
   include/linux/kernel.h:947:26: note: in definition of macro 'container_of'
     void *__mptr = (void *)(ptr);     \
                             ^~~
   include/linux/list.h:377:2: note: in expansion of macro 'list_entry'
     list_entry((ptr)->next, type, member)
     ^~~~~~~~~~
   include/linux/list.h:464:13: note: in expansion of macro 'list_first_entry'
     for (pos = list_first_entry(head, typeof(*pos), member); \
                ^~~~~~~~~~~~~~~~
>> security/security.c:213:3: note: in expansion of macro 'list_for_each_entry'
      list_for_each_entry(P, &security_hook_heads.FUNC, list) { \
      ^~~~~~~~~~~~~~~~~~~
   security/security.c:238:9: note: in expansion of macro 'call_int_hook'
     return call_int_hook(binder_transfer_binder, 0, from, to);
            ^~~~~~~~~~~~~
   In file included from include/linux/kernel.h:10:0,
                    from include/linux/list.h:9,
                    from include/linux/timer.h:5,
                    from include/linux/workqueue.h:9,
                    from include/linux/bpf.h:12,
                    from security/security.c:15:
>> include/linux/list.h:377:18: error: 'struct hlist_head' has no member named 'next'
     list_entry((ptr)->next, type, member)
                     ^
   include/linux/compiler.h:316:19: note: in definition of macro '__compiletime_assert'
      bool __cond = !(condition);    \
                      ^~~~~~~~~
   include/linux/compiler.h:339:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:45:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:948:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
     ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:948:20: note: in expansion of macro '__same_type'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
                       ^~~~~~~~~~~
   include/linux/list.h:366:2: note: in expansion of macro 'container_of'
     container_of(ptr, type, member)
     ^~~~~~~~~~~~
   include/linux/list.h:377:2: note: in expansion of macro 'list_entry'
     list_entry((ptr)->next, type, member)
     ^~~~~~~~~~
   include/linux/list.h:464:13: note: in expansion of macro 'list_first_entry'
     for (pos = list_first_entry(head, typeof(*pos), member); \
                ^~~~~~~~~~~~~~~~
>> security/security.c:213:3: note: in expansion of macro 'list_for_each_entry'
      list_for_each_entry(P, &security_hook_heads.FUNC, list) { \
      ^~~~~~~~~~~~~~~~~~~
   security/security.c:238:9: note: in expansion of macro 'call_int_hook'
     return call_int_hook(binder_transfer_binder, 0, from, to);
            ^~~~~~~~~~~~~
>> include/linux/list.h:377:18: error: 'struct hlist_head' has no member named 'next'
     list_entry((ptr)->next, type, member)
                     ^
   include/linux/compiler.h:316:19: note: in definition of macro '__compiletime_assert'
      bool __cond = !(condition);    \
                      ^~~~~~~~~
   include/linux/compiler.h:339:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:45:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:948:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
     ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:949:6: note: in expansion of macro '__same_type'
        !__same_type(*(ptr), void),   \
         ^~~~~~~~~~~
   include/linux/list.h:366:2: note: in expansion of macro 'container_of'
     container_of(ptr, type, member)
     ^~~~~~~~~~~~
   include/linux/list.h:377:2: note: in expansion of macro 'list_entry'
     list_entry((ptr)->next, type, member)
     ^~~~~~~~~~
   include/linux/list.h:464:13: note: in expansion of macro 'list_first_entry'
     for (pos = list_first_entry(head, typeof(*pos), member); \
                ^~~~~~~~~~~~~~~~

vim +377 include/linux/list.h

^1da177e Linus Torvalds  2005-04-16  358  
^1da177e Linus Torvalds  2005-04-16  359  /**
^1da177e Linus Torvalds  2005-04-16  360   * list_entry - get the struct for this entry
^1da177e Linus Torvalds  2005-04-16  361   * @ptr:	the &struct list_head pointer.
^1da177e Linus Torvalds  2005-04-16  362   * @type:	the type of the struct this is embedded in.
3943f42c Andrey Utkin    2014-11-14  363   * @member:	the name of the list_head within the struct.
^1da177e Linus Torvalds  2005-04-16  364   */
^1da177e Linus Torvalds  2005-04-16  365  #define list_entry(ptr, type, member) \
^1da177e Linus Torvalds  2005-04-16  366  	container_of(ptr, type, member)
^1da177e Linus Torvalds  2005-04-16  367  
^1da177e Linus Torvalds  2005-04-16  368  /**
b5e61818 Pavel Emelianov 2007-05-08  369   * list_first_entry - get the first element from a list
b5e61818 Pavel Emelianov 2007-05-08  370   * @ptr:	the list head to take the element from.
b5e61818 Pavel Emelianov 2007-05-08  371   * @type:	the type of the struct this is embedded in.
3943f42c Andrey Utkin    2014-11-14  372   * @member:	the name of the list_head within the struct.
b5e61818 Pavel Emelianov 2007-05-08  373   *
b5e61818 Pavel Emelianov 2007-05-08  374   * Note, that list is expected to be not empty.
b5e61818 Pavel Emelianov 2007-05-08  375   */
b5e61818 Pavel Emelianov 2007-05-08  376  #define list_first_entry(ptr, type, member) \
b5e61818 Pavel Emelianov 2007-05-08 @377  	list_entry((ptr)->next, type, member)
b5e61818 Pavel Emelianov 2007-05-08  378  

:::::: The code at line 377 was first introduced by commit
:::::: b5e618181a927210f8be1d3d2249d31904ba358d Introduce a handy list_first_entry macro

:::::: TO: Pavel Emelianov <xemul@sw.ru>
:::::: CC: Linus Torvalds <torvalds@woody.linux-foundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

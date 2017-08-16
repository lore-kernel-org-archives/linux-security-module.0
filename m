From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 17 Aug 2017 02:47:45 +0800
Subject: [integrity:next-log-iversion 10/11] include/linux/hrtimer.h:476:1:
	error: 'latent_entropy' attribute only applies to functions and
	variables
Message-ID: <201708170239.MhAfOlhO%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-log-iversion
head:   5873cd8f629e0306acdc40d3a9142eb50ae70c2d
commit: 581c481c0a0de85be1d65a80ea37756757d710d3 [10/11] security: define a new LSM sb_post_remount hook
config: x86_64-randconfig-x000-201733 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout 581c481c0a0de85be1d65a80ea37756757d710d3
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All error/warnings (new ones prefixed by >>):

   include/linux/hrtimer.h:339:37: error: storage class specified for parameter 'tick_cpu_device'
    DECLARE_PER_CPU(struct tick_device, tick_cpu_device);
                                        ^
   include/linux/percpu-defs.h:101:44: note: in definition of macro 'DECLARE_PER_CPU_SECTION'
     extern __PCPU_ATTRS(sec) __typeof__(type) name
                                               ^~~~
   include/linux/hrtimer.h:339:1: note: in expansion of macro 'DECLARE_PER_CPU'
    DECLARE_PER_CPU(struct tick_device, tick_cpu_device);
    ^~~~~~~~~~~~~~~
   include/linux/hrtimer.h:339:37: error: section attribute not allowed for 'tick_cpu_device'
    DECLARE_PER_CPU(struct tick_device, tick_cpu_device);
                                        ^
   include/linux/percpu-defs.h:101:44: note: in definition of macro 'DECLARE_PER_CPU_SECTION'
     extern __PCPU_ATTRS(sec) __typeof__(type) name
                                               ^~~~
   include/linux/hrtimer.h:339:1: note: in expansion of macro 'DECLARE_PER_CPU'
    DECLARE_PER_CPU(struct tick_device, tick_cpu_device);
    ^~~~~~~~~~~~~~~
   In file included from include/linux/sched.h:19:0,
                    from include/linux/cred.h:21,
                    from fs///overlayfs/dir.c:14:
   include/linux/hrtimer.h:345:13: error: storage class specified for parameter 'hrtimer_init'
    extern void hrtimer_init(struct hrtimer *timer, clockid_t which_clock,
                ^~~~~~~~~~~~
   include/linux/hrtimer.h:357:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   include/linux/hrtimer.h:360:68: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    static inline void destroy_hrtimer_on_stack(struct hrtimer *timer) { }
                                                                       ^
   include/linux/hrtimer.h:364:13: error: storage class specified for parameter 'hrtimer_start_range_ns'
    extern void hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
                ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/hrtimer.h:376:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   include/linux/hrtimer.h:380:12: error: storage class specified for parameter 'hrtimer_cancel'
    extern int hrtimer_cancel(struct hrtimer *timer);
               ^~~~~~~~~~~~~~
   include/linux/hrtimer.h:381:12: error: storage class specified for parameter 'hrtimer_try_to_cancel'
    extern int hrtimer_try_to_cancel(struct hrtimer *timer);
               ^~~~~~~~~~~~~~~~~~~~~
   include/linux/hrtimer.h:385:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   include/linux/hrtimer.h:395:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   include/linux/hrtimer.h:400:16: error: storage class specified for parameter '__hrtimer_get_remaining'
    extern ktime_t __hrtimer_get_remaining(const struct hrtimer *timer, bool adjust);
                   ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/hrtimer.h:403:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   include/linux/hrtimer.h:407:12: error: storage class specified for parameter 'hrtimer_get_next_event'
    extern u64 hrtimer_get_next_event(void);
               ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/hrtimer.h:409:13: error: storage class specified for parameter 'hrtimer_active'
    extern bool hrtimer_active(const struct hrtimer *timer);
                ^~~~~~~~~~~~~~
   include/linux/hrtimer.h:415:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   include/linux/hrtimer.h:424:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   include/linux/hrtimer.h:430:1: error: storage class specified for parameter 'hrtimer_forward'
    hrtimer_forward(struct hrtimer *timer, ktime_t now, ktime_t interval);
    ^~~~~~~~~~~~~~~
   include/linux/hrtimer.h:450:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   include/linux/hrtimer.h:456:12: error: storage class specified for parameter 'nanosleep_copyout'
    extern int nanosleep_copyout(struct restart_block *, struct timespec64 *);
               ^~~~~~~~~~~~~~~~~
   include/linux/hrtimer.h:457:13: error: storage class specified for parameter 'hrtimer_nanosleep'
    extern long hrtimer_nanosleep(const struct timespec64 *rqtp,
                ^~~~~~~~~~~~~~~~~
   include/linux/hrtimer.h:461:13: error: storage class specified for parameter 'hrtimer_init_sleeper'
    extern void hrtimer_init_sleeper(struct hrtimer_sleeper *sl,
                ^~~~~~~~~~~~~~~~~~~~
   include/linux/hrtimer.h:464:12: error: storage class specified for parameter 'schedule_hrtimeout_range'
    extern int schedule_hrtimeout_range(ktime_t *expires, u64 delta,
               ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/hrtimer.h:466:12: error: storage class specified for parameter 'schedule_hrtimeout_range_clock'
    extern int schedule_hrtimeout_range_clock(ktime_t *expires,
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/hrtimer.h:470:12: error: storage class specified for parameter 'schedule_hrtimeout'
    extern int schedule_hrtimeout(ktime_t *expires, const enum hrtimer_mode mode);
               ^~~~~~~~~~~~~~~~~~
   include/linux/hrtimer.h:473:13: error: storage class specified for parameter 'hrtimer_run_queues'
    extern void hrtimer_run_queues(void);
                ^~~~~~~~~~~~~~~~~~
   include/linux/hrtimer.h:476:20: error: storage class specified for parameter 'hrtimers_init'
    extern void __init hrtimers_init(void);
                       ^~~~~~~~~~~~~
   include/linux/hrtimer.h:476:20: error: section attribute not allowed for 'hrtimers_init'
   include/linux/hrtimer.h:476:1: warning: '__cold__' attribute ignored [-Wattributes]
    extern void __init hrtimers_init(void);
    ^~~~~~
>> include/linux/hrtimer.h:476:1: error: 'latent_entropy' attribute only applies to functions and variables
   include/linux/hrtimer.h:479:13: error: storage class specified for parameter 'sysrq_timer_list_show'
    extern void sysrq_timer_list_show(void);
                ^~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/seccomp.h:4:0,
                    from include/linux/sched.h:20,
                    from include/linux/cred.h:21,
                    from fs///overlayfs/dir.c:14:
   include/uapi/linux/seccomp.h:47:1: warning: empty declaration
    struct seccomp_data {
    ^~~~~~
   In file included from include/linux/sched.h:20:0,
                    from include/linux/cred.h:21,
                    from fs///overlayfs/dir.c:14:
   include/linux/seccomp.h:54:1: warning: empty declaration
    struct seccomp { };
    ^~~~~~
   include/linux/seccomp.h:55:1: warning: empty declaration
    struct seccomp_filter { };
    ^~~~~~
   include/linux/seccomp.h:58:61: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    static inline int secure_computing(struct seccomp_data *sd) { return 0; }
                                                                ^
   include/linux/seccomp.h:64:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   include/linux/seccomp.h:69:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   include/linux/seccomp.h:74:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   include/linux/seccomp.h:84:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   include/linux/seccomp.h:88:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   include/linux/seccomp.h:99:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   In file included from include/linux/sched.h:24:0,
                    from include/linux/cred.h:21,
                    from fs///overlayfs/dir.c:14:
   include/linux/latencytop.h:13:1: warning: empty declaration
    struct task_struct;
    ^~~~~~
   include/linux/latencytop.h:47:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   include/linux/latencytop.h:51:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   In file included from include/linux/sched.h:25:0,
                    from include/linux/cred.h:21,
                    from fs///overlayfs/dir.c:14:
   include/linux/sched/prio.h:48:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   include/linux/sched/prio.h:56:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   In file included from include/uapi/linux/signal.h:4:0,
                    from include/linux/signal_types.h:9,
                    from include/linux/sched.h:26,
                    from include/linux/cred.h:21,
                    from fs///overlayfs/dir.c:14:
   arch/x86/include/asm/signal.h:20:23: error: storage class specified for parameter 'old_sigset_t'
    typedef unsigned long old_sigset_t;  /* at least 32 bits */
                          ^~~~~~~~~~~~
   arch/x86/include/asm/signal.h:24:3: error: storage class specified for parameter 'sigset_t'
    } sigset_t;
      ^~~~~~~~
   arch/x86/include/asm/signal.h:31:18: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'compat_sigset_t'
    typedef sigset_t compat_sigset_t;
                     ^~~~~~~~~~~~~~~
   In file included from arch/x86/include/asm/signal.h:35:0,
                    from include/uapi/linux/signal.h:4,
                    from include/linux/signal_types.h:9,
                    from include/linux/sched.h:26,
                    from include/linux/cred.h:21,
                    from fs///overlayfs/dir.c:14:
   arch/x86/include/uapi/asm/signal.h:10:1: warning: empty declaration
    struct siginfo;
    ^~~~~~
   In file included from arch/x86/include/uapi/asm/signal.h:93:0,
                    from arch/x86/include/asm/signal.h:35,
                    from include/uapi/linux/signal.h:4,
                    from include/linux/signal_types.h:9,
                    from include/linux/sched.h:26,
                    from include/linux/cred.h:21,
                    from fs///overlayfs/dir.c:14:
   include/uapi/asm-generic/signal-defs.h:17:14: error: storage class specified for parameter '__signalfn_t'
    typedef void __signalfn_t(int);
                 ^~~~~~~~~~~~
   include/uapi/asm-generic/signal-defs.h:18:29: error: expected '=', ',', ';', 'asm' or '__attribute__' before '*' token
    typedef __signalfn_t __user *__sighandler_t;
                                ^
   include/uapi/asm-generic/signal-defs.h:20:14: error: storage class specified for parameter '__restorefn_t'
    typedef void __restorefn_t(void);
                 ^~~~~~~~~~~~~
--
    extern void free_uid(struct user_struct *);
                ^~~~~~~~
   In file included from fs///overlayfs/dir.c:14:0:
   include/linux/cred.h:24:1: warning: empty declaration
    struct cred;
    ^~~~~~
   include/linux/cred.h:25:1: warning: empty declaration
    struct inode;
    ^~~~~~
   include/linux/cred.h:30:1: warning: empty declaration
    struct group_info {
    ^~~~~~
   include/linux/cred.h:46:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   include/linux/cred.h:61:26: error: storage class specified for parameter 'init_groups'
    extern struct group_info init_groups;
                             ^~~~~~~~~~~
   include/linux/cred.h:63:27: error: storage class specified for parameter 'groups_alloc'
    extern struct group_info *groups_alloc(int);
                              ^~~~~~~~~~~~
   include/linux/cred.h:64:13: error: storage class specified for parameter 'groups_free'
    extern void groups_free(struct group_info *);
                ^~~~~~~~~~~
   include/linux/cred.h:66:12: error: storage class specified for parameter 'in_group_p'
    extern int in_group_p(kgid_t);
               ^~~~~~~~~~
   include/linux/cred.h:67:12: error: storage class specified for parameter 'in_egroup_p'
    extern int in_egroup_p(kgid_t);
               ^~~~~~~~~~~
   include/linux/cred.h:82:12: error: storage class specified for parameter 'set_current_groups'
    extern int set_current_groups(struct group_info *);
               ^~~~~~~~~~~~~~~~~~
   include/linux/cred.h:83:13: error: storage class specified for parameter 'set_groups'
    extern void set_groups(struct cred *, struct group_info *);
                ^~~~~~~~~~
   include/linux/cred.h:84:12: error: storage class specified for parameter 'groups_search'
    extern int groups_search(const struct group_info *, kgid_t);
               ^~~~~~~~~~~~~
   include/linux/cred.h:85:13: error: storage class specified for parameter 'may_setgroups'
    extern bool may_setgroups(void);
                ^~~~~~~~~~~~~
   include/linux/cred.h:110:1: warning: empty declaration
    struct cred {
    ^~~~~~
   include/linux/cred.h:150:13: error: storage class specified for parameter '__put_cred'
    extern void __put_cred(struct cred *);
                ^~~~~~~~~~
   include/linux/cred.h:151:13: error: storage class specified for parameter 'exit_creds'
    extern void exit_creds(struct task_struct *);
                ^~~~~~~~~~
   include/linux/cred.h:152:12: error: storage class specified for parameter 'copy_creds'
    extern int copy_creds(struct task_struct *, unsigned long);
               ^~~~~~~~~~
   include/linux/cred.h:153:27: error: storage class specified for parameter 'get_task_cred'
    extern const struct cred *get_task_cred(struct task_struct *);
                              ^~~~~~~~~~~~~
   include/linux/cred.h:154:21: error: storage class specified for parameter 'cred_alloc_blank'
    extern struct cred *cred_alloc_blank(void);
                        ^~~~~~~~~~~~~~~~
   include/linux/cred.h:155:21: error: storage class specified for parameter 'prepare_creds'
    extern struct cred *prepare_creds(void);
                        ^~~~~~~~~~~~~
   include/linux/cred.h:156:21: error: storage class specified for parameter 'prepare_exec_creds'
    extern struct cred *prepare_exec_creds(void);
                        ^~~~~~~~~~~~~~~~~~
   include/linux/cred.h:157:12: error: storage class specified for parameter 'commit_creds'
    extern int commit_creds(struct cred *);
               ^~~~~~~~~~~~
   include/linux/cred.h:158:13: error: storage class specified for parameter 'abort_creds'
    extern void abort_creds(struct cred *);
                ^~~~~~~~~~~
   include/linux/cred.h:159:27: error: storage class specified for parameter 'override_creds'
    extern const struct cred *override_creds(const struct cred *);
                              ^~~~~~~~~~~~~~
   include/linux/cred.h:160:13: error: storage class specified for parameter 'revert_creds'
    extern void revert_creds(const struct cred *);
                ^~~~~~~~~~~~
   include/linux/cred.h:161:21: error: storage class specified for parameter 'prepare_kernel_cred'
    extern struct cred *prepare_kernel_cred(struct task_struct *);
                        ^~~~~~~~~~~~~~~~~~~
   include/linux/cred.h:162:12: error: storage class specified for parameter 'change_create_files_as'
    extern int change_create_files_as(struct cred *, struct inode *);
               ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/cred.h:163:12: error: storage class specified for parameter 'set_security_override'
    extern int set_security_override(struct cred *, u32);
               ^~~~~~~~~~~~~~~~~~~~~
   include/linux/cred.h:164:12: error: storage class specified for parameter 'set_security_override_from_ctx'
    extern int set_security_override_from_ctx(struct cred *, const char *);
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cred.h:165:12: error: storage class specified for parameter 'set_create_files_as'
    extern int set_create_files_as(struct cred *, struct inode *);
               ^~~~~~~~~~~~~~~~~~~
   include/linux/cred.h:166:20: error: storage class specified for parameter 'cred_init'
    extern void __init cred_init(void);
                       ^~~~~~~~~
   include/linux/cred.h:166:20: error: section attribute not allowed for 'cred_init'
   include/linux/cred.h:166:1: warning: '__cold__' attribute ignored [-Wattributes]
    extern void __init cred_init(void);
    ^~~~~~
>> include/linux/cred.h:166:1: error: 'latent_entropy' attribute only applies to functions and variables
   include/linux/cred.h:172:13: error: storage class specified for parameter '__invalid_creds'
    extern void __invalid_creds(const struct cred *, const char *, unsigned);
                ^~~~~~~~~~~~~~~
   include/linux/cred.h:173:13: error: storage class specified for parameter '__validate_process_creds'
    extern void __validate_process_creds(struct task_struct *,
                ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cred.h:176:13: error: storage class specified for parameter 'creds_are_invalid'
    extern bool creds_are_invalid(const struct cred *cred);
                ^~~~~~~~~~~~~~~~~
   include/linux/cred.h:180:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   include/linux/cred.h:195:13: error: storage class specified for parameter 'validate_creds_for_do_exit'
    extern void validate_creds_for_do_exit(struct task_struct *);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cred.h:209:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   include/linux/cred.h:223:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   include/linux/cred.h:242:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   include/linux/cred.h:260:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   include/linux/cred.h:368:30: error: storage class specified for parameter 'init_user_ns'
    extern struct user_namespace init_user_ns;
                                 ^~~~~~~~~~~~
   include/linux/cred.h:373:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   In file included from include/linux/module.h:13:0,
                    from fs///overlayfs/dir.c:15:
   include/linux/kmod.h:42:57: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    static inline int request_module(const char *name, ...) { return -ENOSYS; }
                                                            ^
   include/linux/kmod.h:43:64: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    static inline int request_module_nowait(const char *name, ...) { return -ENOSYS; }
                                                                   ^
   include/linux/kmod.h:48:1: warning: empty declaration
    struct cred;
    ^~~~~~
   include/linux/kmod.h:49:1: warning: empty declaration
    struct file;
    ^~~~~~
   include/linux/kmod.h:56:1: warning: empty declaration
    struct subprocess_info {
    ^~~~~~
   include/linux/kmod.h:70:1: error: storage class specified for parameter 'call_usermodehelper'
    call_usermodehelper(const char *path, char **argv, char **envp, int wait);
    ^~~~~~~~~~~~~~~~~~~
   include/linux/kmod.h:73:1: error: storage class specified for parameter 'call_usermodehelper_setup'
    call_usermodehelper_setup(const char *path, char **argv, char **envp,
    ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kmod.h:79:1: error: storage class specified for parameter 'call_usermodehelper_exec'
    call_usermodehelper_exec(struct subprocess_info *info, int wait);
    ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kmod.h:81:25: error: storage class specified for parameter 'usermodehelper_table'
    extern struct ctl_table usermodehelper_table[];
                            ^~~~~~~~~~~~~~~~~~~~
   include/linux/kmod.h:83:1: warning: empty declaration
    enum umh_disable_depth {
    ^~~~
   include/linux/kmod.h:89:12: error: storage class specified for parameter '__usermodehelper_disable'
    extern int __usermodehelper_disable(enum umh_disable_depth depth);
               ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kmod.h:90:13: error: storage class specified for parameter '__usermodehelper_set_disable_depth'
    extern void __usermodehelper_set_disable_depth(enum umh_disable_depth depth);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kmod.h:93:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   include/linux/kmod.h:98:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   include/linux/kmod.h:102:12: error: storage class specified for parameter 'usermodehelper_read_trylock'
    extern int usermodehelper_read_trylock(void);
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kmod.h:103:13: error: storage class specified for parameter 'usermodehelper_read_lock_wait'
    extern long usermodehelper_read_lock_wait(long timeout);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kmod.h:104:13: error: storage class specified for parameter 'usermodehelper_read_unlock'
    extern void usermodehelper_read_unlock(void);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/x86/include/asm/user.h:7:0,
                    from arch/x86/include/asm/elf.h:10,
                    from include/linux/elf.h:4,
                    from include/linux/module.h:15,
                    from fs///overlayfs/dir.c:15:
   arch/x86/include/asm/user_64.h:50:1: warning: empty declaration
    struct user_i387_struct {
    ^~~~~~
   arch/x86/include/asm/user_64.h:68:1: warning: empty declaration
    struct user_regs_struct {
    ^~~~~~
   arch/x86/include/asm/user_64.h:102:1: warning: empty declaration
    struct user {
    ^~~~~~
..

vim +/latent_entropy +476 include/linux/hrtimer.h

c0a31329 Thomas Gleixner 2006-01-09  474  
c0a31329 Thomas Gleixner 2006-01-09  475  /* Bootup initialization: */
c0a31329 Thomas Gleixner 2006-01-09 @476  extern void __init hrtimers_init(void);
c0a31329 Thomas Gleixner 2006-01-09  477  

:::::: The code at line 476 was first introduced by commit
:::::: c0a3132963db68f1fbbd0e316b73de100fee3f08 [PATCH] hrtimer: hrtimer core code

:::::: TO: Thomas Gleixner <tglx@linutronix.de>
:::::: CC: Linus Torvalds <torvalds@g5.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

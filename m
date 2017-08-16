From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 17 Aug 2017 03:48:27 +0800
Subject: [integrity:next-log-iversion 10/11] fs//attr.c:35:1: error: expected
	'=', ',', ';', 'asm' or '__attribute__' before '{' token
Message-ID: <201708170320.GSiYbLjx%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Mimi,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-log-iversion
head:   5bb9c12032ed1b6bfc148cd8bf24e64996793553
commit: 6acf0ef6e57fb7f665049dbde14d9932826ba46c [10/11] security: define a new LSM sb_post_remount hook
config: i386-tinyconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout 6acf0ef6e57fb7f665049dbde14d9932826ba46c
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

    ^~~~~~~~
   In file included from include/linux/kexec.h:17:0,
                    from include/linux/ima.h:14,
                    from fs//attr.c:18:
   include/linux/crash_core.h:60:13: error: storage class specified for parameter 'vmcoreinfo_note'
    extern u32 *vmcoreinfo_note;
                ^~~~~~~~~~~~~~~
   In file included from include/uapi/linux/elfcore.h:8:0,
                    from include/linux/elfcore.h:9,
                    from include/linux/crash_core.h:5,
                    from include/linux/kexec.h:17,
                    from include/linux/ima.h:14,
                    from fs//attr.c:18:
   include/linux/elf.h:32:18: error: expected declaration specifiers before 'Elf32_Word'
    #define Elf_Word Elf32_Word
                     ^
   include/linux/crash_core.h:62:1: note: in expansion of macro 'Elf_Word'
    Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
    ^~~~~~~~
   include/linux/elf.h:32:18: error: expected declaration specifiers or '...' before 'Elf32_Word'
    #define Elf_Word Elf32_Word
                     ^
   include/linux/crash_core.h:64:17: note: in expansion of macro 'Elf_Word'
    void final_note(Elf_Word *buf);
                    ^~~~~~~~
   In file included from include/linux/kexec.h:17:0,
                    from include/linux/ima.h:14,
                    from fs//attr.c:18:
   include/linux/crash_core.h:66:12: error: section attribute not allowed for 'parse_crashkernel'
    int __init parse_crashkernel(char *cmdline, unsigned long long system_ram,
               ^~~~~~~~~~~~~~~~~
   include/linux/crash_core.h:67:3: warning: '__cold__' attribute ignored [-Wattributes]
      unsigned long long *crash_size, unsigned long long *crash_base);
      ^~~~~~~~
   In file included from include/linux/ima.h:14:0,
                    from fs//attr.c:18:
   include/linux/kexec.h:331:1: warning: empty declaration
    struct pt_regs;
    ^~~~~~
   include/linux/kexec.h:332:1: warning: empty declaration
    struct task_struct;
    ^~~~~~
   include/linux/kexec.h:333:56: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    static inline void __crash_kexec(struct pt_regs *regs) { }
                                                           ^
   include/linux/kexec.h:334:54: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    static inline void crash_kexec(struct pt_regs *regs) { }
                                                         ^
   include/linux/kexec.h:335:61: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    static inline int kexec_should_crash(struct task_struct *p) { return 0; }
                                                                ^
   include/linux/kexec.h:336:44: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    static inline int kexec_crash_loaded(void) { return 0; }
                                               ^
   In file included from fs//attr.c:18:0:
   include/linux/ima.h:15:1: warning: empty declaration
    struct linux_binprm;
    ^~~~~~
   include/linux/ima.h:35:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   include/linux/ima.h:40:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   include/linux/ima.h:45:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   include/linux/ima.h:50:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   include/linux/ima.h:55:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   include/linux/ima.h:61:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   include/linux/ima.h:66:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   include/linux/ima.h:72:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    { }
    ^
   include/linux/ima.h:76:1: warning: empty declaration
    struct kimage;
    ^~~~~~
   include/linux/ima.h:79:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {}
    ^
   include/linux/ima.h:90:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   include/linux/ima.h:95:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   include/linux/ima.h:103:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   include/linux/ima.h:109:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
>> fs//attr.c:35:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
>> fs//attr.c:96:31: error: expected declaration specifiers before ';' token
    EXPORT_SYMBOL(setattr_prepare);
                                  ^
   fs//attr.c:114:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   fs//attr.c:139:32: error: expected declaration specifiers before ';' token
    EXPORT_SYMBOL(inode_newsize_ok);
                                   ^
   fs//attr.c:157:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   fs//attr.c:182:28: error: expected declaration specifiers before ';' token
    EXPORT_SYMBOL(setattr_copy);
                               ^
   fs//attr.c:205:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   fs//attr.c:324:29: error: expected declaration specifiers before ';' token
    EXPORT_SYMBOL(notify_change);
                                ^
   In file included from fs//attr.c:16:0:
   include/linux/security.h:571:20: error: old-style parameter declarations in prototyped function definition
    static inline void security_sb_post_remount(const struct super_block *sb,
                       ^~~~~~~~~~~~~~~~~~~~~~~~
>> fs//attr.c:324:29: error: expected '{' at end of input
    EXPORT_SYMBOL(notify_change);
                                ^

vim +35 fs//attr.c

^1da177e Linus Torvalds    2005-04-16  19  
2c27c65e Christoph Hellwig 2010-06-04  20  /**
31051c85 Jan Kara          2016-05-26  21   * setattr_prepare - check if attribute changes to a dentry are allowed
31051c85 Jan Kara          2016-05-26  22   * @dentry:	dentry to check
2c27c65e Christoph Hellwig 2010-06-04  23   * @attr:	attributes to change
2c27c65e Christoph Hellwig 2010-06-04  24   *
2c27c65e Christoph Hellwig 2010-06-04  25   * Check if we are allowed to change the attributes contained in @attr
31051c85 Jan Kara          2016-05-26  26   * in the given dentry.  This includes the normal unix access permission
31051c85 Jan Kara          2016-05-26  27   * checks, as well as checks for rlimits and others. The function also clears
31051c85 Jan Kara          2016-05-26  28   * SGID bit from mode if user is not allowed to set it. Also file capabilities
31051c85 Jan Kara          2016-05-26  29   * and IMA extended attributes are cleared if ATTR_KILL_PRIV is set.
2c27c65e Christoph Hellwig 2010-06-04  30   *
2c27c65e Christoph Hellwig 2010-06-04  31   * Should be called as the first thing in ->setattr implementations,
2c27c65e Christoph Hellwig 2010-06-04  32   * possibly after taking additional locks.
2c27c65e Christoph Hellwig 2010-06-04  33   */
31051c85 Jan Kara          2016-05-26  34  int setattr_prepare(struct dentry *dentry, struct iattr *attr)
^1da177e Linus Torvalds    2005-04-16 @35  {
31051c85 Jan Kara          2016-05-26  36  	struct inode *inode = d_inode(dentry);
^1da177e Linus Torvalds    2005-04-16  37  	unsigned int ia_valid = attr->ia_valid;
^1da177e Linus Torvalds    2005-04-16  38  
2c27c65e Christoph Hellwig 2010-06-04  39  	/*
2c27c65e Christoph Hellwig 2010-06-04  40  	 * First check size constraints.  These can't be overriden using
2c27c65e Christoph Hellwig 2010-06-04  41  	 * ATTR_FORCE.
2c27c65e Christoph Hellwig 2010-06-04  42  	 */
2c27c65e Christoph Hellwig 2010-06-04  43  	if (ia_valid & ATTR_SIZE) {
2c27c65e Christoph Hellwig 2010-06-04  44  		int error = inode_newsize_ok(inode, attr->ia_size);
2c27c65e Christoph Hellwig 2010-06-04  45  		if (error)
2c27c65e Christoph Hellwig 2010-06-04  46  			return error;
2c27c65e Christoph Hellwig 2010-06-04  47  	}
2c27c65e Christoph Hellwig 2010-06-04  48  
^1da177e Linus Torvalds    2005-04-16  49  	/* If force is set do it anyway. */
^1da177e Linus Torvalds    2005-04-16  50  	if (ia_valid & ATTR_FORCE)
030b533c Jan Kara          2016-05-26  51  		goto kill_priv;
^1da177e Linus Torvalds    2005-04-16  52  
^1da177e Linus Torvalds    2005-04-16  53  	/* Make sure a caller can chown. */
^1da177e Linus Torvalds    2005-04-16  54  	if ((ia_valid & ATTR_UID) &&
8e96e3b7 Eric W. Biederman 2012-03-03  55  	    (!uid_eq(current_fsuid(), inode->i_uid) ||
7fa294c8 Eric W. Biederman 2012-09-02  56  	     !uid_eq(attr->ia_uid, inode->i_uid)) &&
23adbe12 Andy Lutomirski   2014-06-10  57  	    !capable_wrt_inode_uidgid(inode, CAP_CHOWN))
2c27c65e Christoph Hellwig 2010-06-04  58  		return -EPERM;
^1da177e Linus Torvalds    2005-04-16  59  
^1da177e Linus Torvalds    2005-04-16  60  	/* Make sure caller can chgrp. */
^1da177e Linus Torvalds    2005-04-16  61  	if ((ia_valid & ATTR_GID) &&
8e96e3b7 Eric W. Biederman 2012-03-03  62  	    (!uid_eq(current_fsuid(), inode->i_uid) ||
8e96e3b7 Eric W. Biederman 2012-03-03  63  	    (!in_group_p(attr->ia_gid) && !gid_eq(attr->ia_gid, inode->i_gid))) &&
23adbe12 Andy Lutomirski   2014-06-10  64  	    !capable_wrt_inode_uidgid(inode, CAP_CHOWN))
2c27c65e Christoph Hellwig 2010-06-04  65  		return -EPERM;
^1da177e Linus Torvalds    2005-04-16  66  
^1da177e Linus Torvalds    2005-04-16  67  	/* Make sure a caller can chmod. */
^1da177e Linus Torvalds    2005-04-16  68  	if (ia_valid & ATTR_MODE) {
2e149670 Serge E. Hallyn   2011-03-23  69  		if (!inode_owner_or_capable(inode))
2c27c65e Christoph Hellwig 2010-06-04  70  			return -EPERM;
^1da177e Linus Torvalds    2005-04-16  71  		/* Also check the setgid bit! */
^1da177e Linus Torvalds    2005-04-16  72  		if (!in_group_p((ia_valid & ATTR_GID) ? attr->ia_gid :
7fa294c8 Eric W. Biederman 2012-09-02  73  				inode->i_gid) &&
23adbe12 Andy Lutomirski   2014-06-10  74  		    !capable_wrt_inode_uidgid(inode, CAP_FSETID))
^1da177e Linus Torvalds    2005-04-16  75  			attr->ia_mode &= ~S_ISGID;
^1da177e Linus Torvalds    2005-04-16  76  	}
^1da177e Linus Torvalds    2005-04-16  77  
^1da177e Linus Torvalds    2005-04-16  78  	/* Check for setting the inode time. */
9767d749 Miklos Szeredi    2008-07-01  79  	if (ia_valid & (ATTR_MTIME_SET | ATTR_ATIME_SET | ATTR_TIMES_SET)) {
2e149670 Serge E. Hallyn   2011-03-23  80  		if (!inode_owner_or_capable(inode))
2c27c65e Christoph Hellwig 2010-06-04  81  			return -EPERM;
^1da177e Linus Torvalds    2005-04-16  82  	}
2c27c65e Christoph Hellwig 2010-06-04  83  
030b533c Jan Kara          2016-05-26  84  kill_priv:
030b533c Jan Kara          2016-05-26  85  	/* User has permission for the change */
030b533c Jan Kara          2016-05-26  86  	if (ia_valid & ATTR_KILL_PRIV) {
030b533c Jan Kara          2016-05-26  87  		int error;
030b533c Jan Kara          2016-05-26  88  
030b533c Jan Kara          2016-05-26  89  		error = security_inode_killpriv(dentry);
030b533c Jan Kara          2016-05-26  90  		if (error)
030b533c Jan Kara          2016-05-26  91  			return error;
030b533c Jan Kara          2016-05-26  92  	}
030b533c Jan Kara          2016-05-26  93  
2c27c65e Christoph Hellwig 2010-06-04  94  	return 0;
^1da177e Linus Torvalds    2005-04-16  95  }
31051c85 Jan Kara          2016-05-26 @96  EXPORT_SYMBOL(setattr_prepare);
^1da177e Linus Torvalds    2005-04-16  97  

:::::: The code at line 35 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

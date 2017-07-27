From: lkp@intel.com (kbuild test robot)
Date: Thu, 27 Jul 2017 13:38:22 +0800
Subject: [PATCH 09/12] ima: introduce securityfs interfaces for digest
	lists
In-Reply-To: <20170725154423.24845-10-roberto.sassu@huawei.com>
Message-ID: <201707271347.VwL6L70r%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Roberto,

[auto build test WARNING on integrity/next]
[also build test WARNING on v4.13-rc2 next-20170726]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Roberto-Sassu/ima-measure-digest-lists-instead-of-individual-files/20170727-123131
base:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next
config: x86_64-randconfig-x000-201730 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   In file included from security/integrity/ima/ima_fs.c:27:0:
   security/integrity/ima/ima.h: In function 'ima_parse_digest_list_metadata':
   security/integrity/ima/ima.h:165:10: error: 'ENOTSUP' undeclared (first use in this function)
     return -ENOTSUP;
             ^~~~~~~
   security/integrity/ima/ima.h:165:10: note: each undeclared identifier is reported only once for each function it appears in
>> security/integrity/ima/ima.h:166:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^

vim +166 security/integrity/ima/ima.h

d68a6fe9f Mimi Zohar      2016-12-19  135  
3323eec92 Mimi Zohar      2009-02-04  136  /* Internal IMA function definitions */
3323eec92 Mimi Zohar      2009-02-04  137  int ima_init(void);
bab739378 Mimi Zohar      2009-02-04  138  int ima_fs_init(void);
3323eec92 Mimi Zohar      2009-02-04  139  int ima_add_template_entry(struct ima_template_entry *entry, int violation,
9803d413f Roberto Sassu   2013-06-07  140  			   const char *op, struct inode *inode,
9803d413f Roberto Sassu   2013-06-07  141  			   const unsigned char *filename);
c7c8bb237 Dmitry Kasatkin 2013-04-25  142  int ima_calc_file_hash(struct file *file, struct ima_digest_data *hash);
11d7646df Dmitry Kasatkin 2014-04-17  143  int ima_calc_buffer_hash(const void *buf, loff_t len,
11d7646df Dmitry Kasatkin 2014-04-17  144  			 struct ima_digest_data *hash);
b6f8f16f4 Roberto Sassu   2013-11-08  145  int ima_calc_field_array_hash(struct ima_field_data *field_data,
b6f8f16f4 Roberto Sassu   2013-11-08  146  			      struct ima_template_desc *desc, int num_fields,
c7c8bb237 Dmitry Kasatkin 2013-04-25  147  			      struct ima_digest_data *hash);
09ef54359 Dmitry Kasatkin 2013-06-07  148  int __init ima_calc_boot_aggregate(struct ima_digest_data *hash);
7d802a227 Roberto Sassu   2013-06-07  149  void ima_add_violation(struct file *file, const unsigned char *filename,
8d94eb9b5 Roberto Sassu   2015-04-11  150  		       struct integrity_iint_cache *iint,
3323eec92 Mimi Zohar      2009-02-04  151  		       const char *op, const char *cause);
76bb28f61 Dmitry Kasatkin 2012-06-08  152  int ima_init_crypto(void);
3ce1217d6 Roberto Sassu   2013-06-07  153  void ima_putc(struct seq_file *m, void *data, int datalen);
45b26133b Mimi Zohar      2015-06-11  154  void ima_print_digest(struct seq_file *m, u8 *digest, u32 size);
a71dc65d3 Roberto Sassu   2013-06-07  155  struct ima_template_desc *ima_template_desc_current(void);
94c3aac56 Mimi Zohar      2016-12-19  156  int ima_restore_measurement_entry(struct ima_template_entry *entry);
94c3aac56 Mimi Zohar      2016-12-19  157  int ima_restore_measurement_list(loff_t bufsize, void *buf);
4b1c19b3d Roberto Sassu   2017-07-25  158  struct ima_digest *ima_lookup_loaded_digest(u8 *digest);
4b1c19b3d Roberto Sassu   2017-07-25  159  int ima_add_digest_data_entry(u8 *digest);
3580b2df6 Roberto Sassu   2017-07-25  160  #ifdef CONFIG_IMA_DIGEST_LIST
3580b2df6 Roberto Sassu   2017-07-25  161  ssize_t ima_parse_digest_list_metadata(loff_t size, void *buf);
3580b2df6 Roberto Sassu   2017-07-25  162  #else
3580b2df6 Roberto Sassu   2017-07-25  163  static inline ssize_t ima_parse_digest_list_metadata(loff_t size, void *buf)
3580b2df6 Roberto Sassu   2017-07-25  164  {
3580b2df6 Roberto Sassu   2017-07-25 @165  	return -ENOTSUP;
3580b2df6 Roberto Sassu   2017-07-25 @166  }
3580b2df6 Roberto Sassu   2017-07-25  167  #endif
7b8589cc2 Mimi Zohar      2016-12-19  168  int ima_measurements_show(struct seq_file *m, void *v);
d158847ae Mimi Zohar      2016-12-19  169  unsigned long ima_get_binary_runtime_size(void);
a71dc65d3 Roberto Sassu   2013-06-07  170  int ima_init_template(void);
3f23d624d Mimi Zohar      2016-12-19  171  void ima_init_template_list(void);
3323eec92 Mimi Zohar      2009-02-04  172  

:::::: The code at line 166 was first introduced by commit
:::::: 3580b2df63c2ec47030a481fea2d2c865124aff4 ima: added parser of digest lists metadata

:::::: TO: Roberto Sassu <roberto.sassu@huawei.com>
:::::: CC: 0day robot <fengguang.wu@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

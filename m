From: lkp@intel.com (kbuild test robot)
Date: Thu, 27 Jul 2017 13:15:15 +0800
Subject: [PATCH 06/12] ima: added parser of digest lists metadata
In-Reply-To: <20170725154423.24845-7-roberto.sassu@huawei.com>
Message-ID: <201707271351.WZlZWWoO%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Roberto,

[auto build test ERROR on integrity/next]
[also build test ERROR on v4.13-rc2 next-20170726]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Roberto-Sassu/ima-measure-digest-lists-instead-of-individual-files/20170727-123131
base:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next
config: x86_64-randconfig-x000-201730 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   In file included from security/integrity/ima/ima_fs.c:27:0:
   security/integrity/ima/ima.h: In function 'ima_parse_digest_list_metadata':
>> security/integrity/ima/ima.h:165:10: error: 'ENOTSUP' undeclared (first use in this function)
     return -ENOTSUP;
             ^~~~~~~
   security/integrity/ima/ima.h:165:10: note: each undeclared identifier is reported only once for each function it appears in

vim +/ENOTSUP +165 security/integrity/ima/ima.h

   135	
   136	/* Internal IMA function definitions */
   137	int ima_init(void);
   138	int ima_fs_init(void);
   139	int ima_add_template_entry(struct ima_template_entry *entry, int violation,
   140				   const char *op, struct inode *inode,
   141				   const unsigned char *filename);
   142	int ima_calc_file_hash(struct file *file, struct ima_digest_data *hash);
   143	int ima_calc_buffer_hash(const void *buf, loff_t len,
   144				 struct ima_digest_data *hash);
   145	int ima_calc_field_array_hash(struct ima_field_data *field_data,
   146				      struct ima_template_desc *desc, int num_fields,
   147				      struct ima_digest_data *hash);
   148	int __init ima_calc_boot_aggregate(struct ima_digest_data *hash);
   149	void ima_add_violation(struct file *file, const unsigned char *filename,
   150			       struct integrity_iint_cache *iint,
   151			       const char *op, const char *cause);
   152	int ima_init_crypto(void);
   153	void ima_putc(struct seq_file *m, void *data, int datalen);
   154	void ima_print_digest(struct seq_file *m, u8 *digest, u32 size);
   155	struct ima_template_desc *ima_template_desc_current(void);
   156	int ima_restore_measurement_entry(struct ima_template_entry *entry);
   157	int ima_restore_measurement_list(loff_t bufsize, void *buf);
   158	struct ima_digest *ima_lookup_loaded_digest(u8 *digest);
   159	int ima_add_digest_data_entry(u8 *digest);
   160	#ifdef CONFIG_IMA_DIGEST_LIST
   161	ssize_t ima_parse_digest_list_metadata(loff_t size, void *buf);
   162	#else
   163	static inline ssize_t ima_parse_digest_list_metadata(loff_t size, void *buf)
   164	{
 > 165		return -ENOTSUP;
   166	}
   167	#endif
   168	int ima_measurements_show(struct seq_file *m, void *v);
   169	unsigned long ima_get_binary_runtime_size(void);
   170	int ima_init_template(void);
   171	void ima_init_template_list(void);
   172	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

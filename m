From: lkp@intel.com (kbuild test robot)
Date: Thu, 14 Jun 2018 09:07:00 +0800
Subject: [integrity:next-integrity-queued 22/22]
	security/integrity/evm/evm_crypto.c:93: undefined reference to
	`hash_algo_name'
Message-ID: <201806140958.6pTSK5nT%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity-queued
head:   6497009f11c75bae55a3329dedcd3eeb8e282eaf
commit: 6497009f11c75bae55a3329dedcd3eeb8e282eaf [22/22] evm: Allow non-SHA1 digital signatures
config: x86_64-randconfig-ws0-06140615 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        git checkout 6497009f11c75bae55a3329dedcd3eeb8e282eaf
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   security/integrity/evm/evm_crypto.o: In function `init_desc':
>> security/integrity/evm/evm_crypto.c:93: undefined reference to `hash_algo_name'

vim +93 security/integrity/evm/evm_crypto.c

    76	
    77	static struct shash_desc *init_desc(char type, uint8_t hash_algo)
    78	{
    79		long rc;
    80		const char *algo;
    81		struct crypto_shash **tfm;
    82		struct shash_desc *desc;
    83	
    84		if (type == EVM_XATTR_HMAC) {
    85			if (!(evm_initialized & EVM_INIT_HMAC)) {
    86				pr_err_once("HMAC key is not set\n");
    87				return ERR_PTR(-ENOKEY);
    88			}
    89			tfm = &hmac_tfm;
    90			algo = evm_hmac;
    91		} else {
    92			tfm = &evm_tfm[hash_algo];
  > 93			algo = hash_algo_name[hash_algo];
    94		}
    95	
    96		if (*tfm == NULL) {
    97			mutex_lock(&mutex);
    98			if (*tfm)
    99				goto out;
   100			*tfm = crypto_alloc_shash(algo, 0,
   101						  CRYPTO_ALG_ASYNC | CRYPTO_NOLOAD);
   102			if (IS_ERR(*tfm)) {
   103				rc = PTR_ERR(*tfm);
   104				pr_err("Can not allocate %s (reason: %ld)\n", algo, rc);
   105				*tfm = NULL;
   106				mutex_unlock(&mutex);
   107				return ERR_PTR(rc);
   108			}
   109			if (type == EVM_XATTR_HMAC) {
   110				rc = crypto_shash_setkey(*tfm, evmkey, evmkey_len);
   111				if (rc) {
   112					crypto_free_shash(*tfm);
   113					*tfm = NULL;
   114					mutex_unlock(&mutex);
   115					return ERR_PTR(rc);
   116				}
   117			}
   118	out:
   119			mutex_unlock(&mutex);
   120		}
   121	
   122		desc = kmalloc(sizeof(*desc) + crypto_shash_descsize(*tfm),
   123				GFP_KERNEL);
   124		if (!desc)
   125			return ERR_PTR(-ENOMEM);
   126	
   127		desc->tfm = *tfm;
   128		desc->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
   129	
   130		rc = crypto_shash_init(desc);
   131		if (rc) {
   132			kfree(desc);
   133			return ERR_PTR(rc);
   134		}
   135		return desc;
   136	}
   137	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

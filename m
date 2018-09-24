From: lkp@intel.com (kbuild test robot)
Date: Mon, 24 Sep 2018 11:03:48 +0800
Subject: [PATCH 2/2] netfilter: nf_tables: add requirements for
	connsecmark support
In-Reply-To: <20180923091611.19815-2-cgzones@googlemail.com>
References: <20180923091611.19815-2-cgzones@googlemail.com>
Message-ID: <201809241157.5rEcbeRM%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Christian,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on nf-next/master]
[also build test ERROR on v4.19-rc5 next-20180921]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Christian-G-ttsche/netfilter-nf_tables-add-SECMARK-support/20180923-213820
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf-next.git master
config: x86_64-randconfig-s3-09241007 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   net//netfilter/nft_ct.c: In function 'nft_ct_set_eval':
>> net//netfilter/nft_ct.c:303:22: error: 'value' undeclared (first use in this function); did you mean 'false'?
      if (ct->secmark != value) {
                         ^~~~~
                         false
   net//netfilter/nft_ct.c:303:22: note: each undeclared identifier is reported only once for each function it appears in

vim +303 net//netfilter/nft_ct.c

   275	
   276	static void nft_ct_set_eval(const struct nft_expr *expr,
   277				    struct nft_regs *regs,
   278				    const struct nft_pktinfo *pkt)
   279	{
   280		const struct nft_ct *priv = nft_expr_priv(expr);
   281		struct sk_buff *skb = pkt->skb;
   282	#ifdef CONFIG_NF_CONNTRACK_MARK
   283		u32 value = regs->data[priv->sreg];
   284	#endif
   285		enum ip_conntrack_info ctinfo;
   286		struct nf_conn *ct;
   287	
   288		ct = nf_ct_get(skb, &ctinfo);
   289		if (ct == NULL || nf_ct_is_template(ct))
   290			return;
   291	
   292		switch (priv->key) {
   293	#ifdef CONFIG_NF_CONNTRACK_MARK
   294		case NFT_CT_MARK:
   295			if (ct->mark != value) {
   296				ct->mark = value;
   297				nf_conntrack_event_cache(IPCT_MARK, ct);
   298			}
   299			break;
   300	#endif
   301	#ifdef CONFIG_NF_CONNTRACK_SECMARK
   302		case NFT_CT_SECMARK:
 > 303			if (ct->secmark != value) {
   304				ct->secmark = value;
   305				nf_conntrack_event_cache(IPCT_SECMARK, ct);
   306			}
   307			break;
   308	#endif
   309	#ifdef CONFIG_NF_CONNTRACK_LABELS
   310		case NFT_CT_LABELS:
   311			nf_connlabels_replace(ct,
   312					      &regs->data[priv->sreg],
   313					      &regs->data[priv->sreg],
   314					      NF_CT_LABELS_MAX_SIZE / sizeof(u32));
   315			break;
   316	#endif
   317	#ifdef CONFIG_NF_CONNTRACK_EVENTS
   318		case NFT_CT_EVENTMASK: {
   319			struct nf_conntrack_ecache *e = nf_ct_ecache_find(ct);
   320			u32 ctmask = regs->data[priv->sreg];
   321	
   322			if (e) {
   323				if (e->ctmask != ctmask)
   324					e->ctmask = ctmask;
   325				break;
   326			}
   327	
   328			if (ctmask && !nf_ct_is_confirmed(ct))
   329				nf_ct_ecache_ext_add(ct, ctmask, 0, GFP_ATOMIC);
   330			break;
   331		}
   332	#endif
   333		default:
   334			break;
   335		}
   336	}
   337	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

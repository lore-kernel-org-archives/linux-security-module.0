From: davem@davemloft.net (David Miller)
Date: Wed, 18 Oct 2017 14:11:55 +0100 (WEST)
Subject: [PATCH net-next v6 0/5] bpf: security: New file mode and LSM
	hooks for eBPF object permission control
In-Reply-To: <20171018.134729.837318478487425125.davem@davemloft.net>
References: <20171016191135.8046-1-chenbofeng.kernel@gmail.com>
	<20171018.134729.837318478487425125.davem@davemloft.net>
Message-ID: <20171018.141155.1830215730026401984.davem@davemloft.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Wed, 18 Oct 2017 13:47:29 +0100 (WEST)

> Series applied.

I had to revert as this breaks the build:

net/netfilter/xt_bpf.c: In function ?__bpf_mt_check_path?:
net/netfilter/xt_bpf.c:59:7: error: too few arguments to function ?bpf_obj_get_user?
  fd = bpf_obj_get_user(path);
       ^~~~~~~~~~~~~~~~
????{.n?+???????+%?????????w??{.n?+????{??????????v?^?)????w*jg??????????j????G?????????j:+v???w?j?m????????w?????f???h?????????

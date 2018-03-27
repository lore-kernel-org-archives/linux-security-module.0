From: jmorris@namei.org (James Morris)
Date: Tue, 27 Mar 2018 19:08:08 +1100 (AEDT)
Subject: [RFC PATCH 2/2] security: Add mechanism to (un)load LSMs after
	boot time
In-Reply-To: <CAMp4zn-NK4gre0cwaBnYrujVXEpA97OGzcbxqrySz=X91Lu+kQ@mail.gmail.com>
References: <cover.1522091329.git.sargun@sargun.me>
	<af077529868a212caeb822ae79d72a1ac40f17ba.1522091329.git.sargun@sargun.me>
	<fbe62489-42a7-6418-351a-5661de7deee3@huawei.com>
	<CAMp4zn-NK4gre0cwaBnYrujVXEpA97OGzcbxqrySz=X91Lu+kQ@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1803271902590.9495@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 26 Mar 2018, Sargun Dhillon wrote:

> Today, the only "mutable" module we have is SELinux. It has a kernel
> config flag which determines if it is unloadable (mutable) or not. If
> you look at the patchset, it, in fact, sets mutability based on that
> config flag:
> 
> 
> -       security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), "selinux");
> +       security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), "selinux",
> +                               IS_ENABLED(CONFIG_SECURITY_SELINUX_DISABLE));
> 

There has been discussion about removing the ability to unload SELinux -- 
not sure what the current status of that is.

Regardless, it's a special case for historical reasons and should not be 
thought of as an example for future use.

> Similarly, modules can change this behaviour based on their own
> choices, whether that be config flags, boot parameters, or similar. In
> my opinion, most LSMs should never be unloadable. 

All, probably.


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

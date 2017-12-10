From: james.l.morris@oracle.com (James Morris)
Date: Mon, 11 Dec 2017 09:10:04 +1100 (AEDT)
Subject: [RFC v2 1/3] security: Add safe, dynamic (runtime-loadable) hook
	support
In-Reply-To: <0f07d85c-7434-a92b-0060-a31ad31ab962@schaufler-ca.com>
References: <cover.1512704909.git.sargun@netflix.com>
	<5c089f6eb3bcec36e6021db7dcfcd4409be99111.1512704909.git.sargun@netflix.com>
	<0f07d85c-7434-a92b-0060-a31ad31ab962@schaufler-ca.com>
Message-ID: <alpine.LFD.2.20.1712110909081.19397@localhost>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 8 Dec 2017, Casey Schaufler wrote:

> Would it make sense to have lsm_dynamic.h ?

Yes.

> 
> > +	DYNAMIC_SECURITY_HOOK_binder_set_context_mgr,

Please trim replies!

-- 
James Morris
<james.l.morris@oracle.com>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

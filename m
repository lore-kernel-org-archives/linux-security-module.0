From: casey@schaufler-ca.com (Casey Schaufler)
Date: Sun, 1 Apr 2018 10:32:32 -0700
Subject: [PATCH 0/4] security: Split out hook definitions into
	lsm_hook_types.h
In-Reply-To: <cover.1522577650.git.sargun@sargun.me>
References: <cover.1522577650.git.sargun@sargun.me>
Message-ID: <06c4e61e-399f-a1f8-bd45-a27d0eb4571b@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 4/1/2018 3:17 AM, Sargun Dhillon wrote:
> This moves all of the LSM hooks type information into a separate file,
> lsm_hook_types.h. This enables us to use this file, along with macros
> to generate the security_hook_heads struct, as well as the security
> hooks union without having to duplicate definitions.
>
> This will be useful for further datastructures which want to use
> the set of security hooks in a completely unrolled way, along
> with the type information there within.

Can you explain what this patch set is trying to accomplish?
I see no value. I see massive complexity. Why is this better
than what is there now?

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

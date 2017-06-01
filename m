From: casey@schaufler-ca.com (Casey Schaufler)
Date: Thu, 1 Jun 2017 16:59:24 -0700
Subject: [PATCH] procfs: add smack subdir to attrs
In-Reply-To: <alpine.LRH.2.20.1706020937290.16910@namei.org>
References: <d2876592-e13a-b407-15b0-bdf9b0d49f75@schaufler-ca.com>
	<alpine.LRH.2.20.1706020937290.16910@namei.org>
Message-ID: <76f4dd96-76ca-a7ec-313a-b8ab72b0181f@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 6/1/2017 4:38 PM, James Morris wrote:
> On Thu, 1 Jun 2017, Casey Schaufler wrote:
>
>> Subject: [PATCH] procfs: add smack subdir to attrs
> Is there value in this without major stacking support?

Yes. If a Smack aware application reads /proc/self/attr/current
it has no way to know if what it sees is a Smack label or an
SELinux context. True, the application can look elsewhere
(i.e. /sys/kernel/security/lsm) to find out which is enabled.
But the real fix is for Smack to use a different interface
than SELinux. Which is what this does. True, it will be even
more important when/if major stacking comes in, but it is still
significant now, and I would like to have it regardless of
the future acceptance of major stacking.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

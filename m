From: casey@schaufler-ca.com (Casey Schaufler)
Date: Thu, 6 Apr 2017 15:50:36 -0700
Subject: [PATCH RFC 00/11] LSM: Stacking for major security modules
In-Reply-To: <alpine.LRH.2.20.1704070758310.27111@namei.org>
References: <509e0281-9f8a-83c2-f9d6-5532903cda46@schaufler-ca.com>
	<1491503171.4532.10.camel@tycho.nsa.gov>
	<c6d9da56-fd4d-e8e5-caa5-718de74db261@schaufler-ca.com>
	<1491511104.4532.17.camel@tycho.nsa.gov>
	<alpine.LRH.2.20.1704070758310.27111@namei.org>
Message-ID: <d812c25c-bb74-9e0c-a607-6a5e7efb73cc@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 4/6/2017 3:24 PM, James Morris wrote:
> On Thu, 6 Apr 2017, Stephen Smalley wrote:
>
>> Yes, but in the meantime, if you want to be able to test
>> CONFIG_SECURITY_STACKING=y with modules in enforcing mode on
>> distributions that enable a major security module, it seems like you
>> need to provide some way of handling this compatibly.
> Regardless of the config option, we can't break existing userspace. This 
> is a long-standing Linux kernel development rule.
>
> You'll need to implement new interfaces for any changes.

The big question is SO_PEERSEC. SO_PEERSEC provides
undefined "security credentials". You don't need to
define a new interface here because the interface allows
different configurations (e.g. Smack active, SELinux
active, both active) to provide different information.
The basic argument today is over whether

	"System"

is preferred over

	"smack='System'"

in the case where only Smack is enabled, and to what extent.
The majority opinion seems to be that the self-identifying
attribute should *never* be used unless there are in fact
multiple modules providing data. I personally believe that
this is short sighted and will discourage the development
of run time environments that are capable of dealing with
multiple concurrent security modules. But, I'm not going
to let my own stubborn streak get in the way of progress.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

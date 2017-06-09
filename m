From: jmorris@namei.org (James Morris)
Date: Fri, 9 Jun 2017 13:54:25 +1000 (AEST)
Subject: [kernel-hardening] [PATCH 0/6] LSM: Security module blob
	management
In-Reply-To: <2a28d30a-22d3-33ff-581c-f1347fbbae74@nmatt.com>
References: <59cec608-608e-6de6-21d9-bdec7b0ded3b@schaufler-ca.com>
	<2a28d30a-22d3-33ff-581c-f1347fbbae74@nmatt.com>
Message-ID: <alpine.LRH.2.20.1706091353380.8421@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 8 Jun 2017, Matt Brown wrote:

> On 6/8/17 4:43 PM, Casey Schaufler wrote:
> > Subject: [PATCH 0/6] LSM: Security module blob management
> > 
> > This patch set moves management of security blobs out of
> > the Linux security modules and into the security module
> > infrastructure. This allows "major" security modules that
> > use blobs to be stacked, just as "minor" modules that
> > do not use blobs can be stacked today. It stops short of
> > providing a safe interface for the Netlabel and SO_PEERSEC.
> > As a result, any of the existing security modules may be
> > used in combination except for SELinux and Smack.
> 
> Very excited about this! I can definitely see use cases for special
> purpose LSMs that require data blobs but do not replace things like
> SELinux, SMACK or AppArmor. I have had a few ideas recently that would
> not be possible under the current setup of one shared blob.

Please post details of these ideas once you have say a prototype working 
with Casey's patches.


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

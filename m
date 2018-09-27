From: jmorris@namei.org (James Morris)
Date: Fri, 28 Sep 2018 08:13:32 +1000 (AEST)
Subject: [PATCH v4 04/19] SELinux: Remove cred security blob poisoning
In-Reply-To: <5360cd42-5827-58af-515c-6e1ded1d9154@schaufler-ca.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
	<5360cd42-5827-58af-515c-6e1ded1d9154@schaufler-ca.com>
Message-ID: <alpine.LRH.2.21.1809280813270.8410@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 21 Sep 2018, Casey Schaufler wrote:

> The SELinux specific credential poisioning only makes sense
> if SELinux is managing the credentials. As the intent of this
> patch set is to move the blob management out of the modules
> and into the infrastructure, the SELinux specific code has
> to go. The poisioning could be introduced into the infrastructure
> at some later date.

If it's useful, it should be incorporated into core LSM, otherwise that's 
a regression for SELinux.


-- 
James Morris
<jmorris@namei.org>

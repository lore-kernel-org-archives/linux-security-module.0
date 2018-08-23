From: jmorris@namei.org (James Morris)
Date: Fri, 24 Aug 2018 02:48:39 +1000 (AEST)
Subject: [PATCH v1] security/capabilities: remove check for -EINVAL
In-Reply-To: <20180822135825.GA7223@mail.hallyn.com>
References: <20180822115240.18196-1-christian@brauner.io>
	<20180822135825.GA7223@mail.hallyn.com>
Message-ID: <alpine.LRH.2.21.1808240248180.17440@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 22 Aug 2018, Serge E. Hallyn wrote:

> Quoting Christian Brauner (christian at brauner.io):
> > bprm_caps_from_vfs_caps() never returned -EINVAL so remove the
> > rc == -EINVAL check.
> > 
> > Signed-off-by: Christian Brauner <christian@brauner.io>
> 
> Thanks.
> 
> Reviewed-by: Serge Hallyn <serge@hallyn.com>

Thanks, I'll queue this for post -rc1 next-general.


-- 
James Morris
<jmorris@namei.org>

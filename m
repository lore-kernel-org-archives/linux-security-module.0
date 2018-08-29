From: jmorris@namei.org (James Morris)
Date: Thu, 30 Aug 2018 02:09:21 +1000 (AEST)
Subject: [PATCH v1] security/capabilities: remove check for -EINVAL
In-Reply-To: <20180822115240.18196-1-christian@brauner.io>
References: <20180822115240.18196-1-christian@brauner.io>
Message-ID: <alpine.LRH.2.21.1808300209110.7406@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 22 Aug 2018, Christian Brauner wrote:

> bprm_caps_from_vfs_caps() never returned -EINVAL so remove the
> rc == -EINVAL check.
> 
> Signed-off-by: Christian Brauner <christian@brauner.io>

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general


-- 
James Morris
<jmorris@namei.org>

From: jmorris@namei.org (James Morris)
Date: Fri, 7 Sep 2018 06:31:33 +1000 (AEST)
Subject: [PATCH] seccomp: remove unnecessary unlikely()
In-Reply-To: <20180905203443.32289-1-igor.stoppa@huawei.com>
References: <20180905203443.32289-1-igor.stoppa@huawei.com>
Message-ID: <alpine.LRH.2.21.1809070631170.31431@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 5 Sep 2018, Igor Stoppa wrote:

> WARN_ON() already contains an unlikely(), so it's not necessary to wrap it
> into another.
> 
> Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
> Acked-by: Kees Cook <keescook@chromium.org>
> Cc: linux-security-module at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general

and next-testing.


Thanks!

-- 
James Morris
<jmorris@namei.org>

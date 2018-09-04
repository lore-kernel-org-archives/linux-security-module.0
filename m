From: jmorris@namei.org (James Morris)
Date: Wed, 5 Sep 2018 04:57:55 +1000 (AEST)
Subject: [PATCH] security: tomoyo: Fix obsolete function
In-Reply-To: <1536050499-20889-1-git-send-email-dingxiang@cmss.chinamobile.com>
References: <1536050499-20889-1-git-send-email-dingxiang@cmss.chinamobile.com>
Message-ID: <alpine.LRH.2.21.1809050457380.17815@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 4 Sep 2018, Ding Xiang wrote:

> simple_strtoul is obsolete, and use kstrtouint instead
> 
> Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general

and next-testing.



-- 
James Morris
<jmorris@namei.org>

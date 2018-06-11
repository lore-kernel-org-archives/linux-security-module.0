From: penguin-kernel@i-love.sakura.ne.jp (Tetsuo Handa)
Date: Tue, 12 Jun 2018 05:57:37 +0900
Subject: [-next PATCH] security: use octal not symbolic permissions
In-Reply-To: <1e91f8e10ce76d3208239b6b5899aab76d1543ff.1528743633.git.joe@perches.com>
References: <1e91f8e10ce76d3208239b6b5899aab76d1543ff.1528743633.git.joe@perches.com>
Message-ID: <e11959c0-9e1c-4f4a-151f-8f3031d882c4@i-love.sakura.ne.jp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 2018/06/12 4:01, Joe Perches wrote:
> Currently security files use a mixture of octal and symbolic styles
> for permissions.
> 
> Using octal and not symbolic permissions is preferred by many as more
> readable.
> 
> see: https://lkml.org/lkml/2016/8/2/1945
> 
> Prefer the direct use of octal for permissions.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> 
>  security/tomoyo/condition.c     | 18 ++++++-------
> 
> diff --git a/security/tomoyo/condition.c b/security/tomoyo/condition.c

Acked-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

for the TOMOYO part.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

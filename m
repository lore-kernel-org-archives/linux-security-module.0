From: jmorris@namei.org (James Morris)
Date: Mon, 13 Mar 2017 16:59:46 +1100 (AEDT)
Subject: [PATCH] TOMOYO: Switch from per "struct cred" blob to per "struct
	task_struct" blob.
In-Reply-To: <02803f61-29e6-97ea-7ed2-babce48206da@canonical.com>
References: <1489293685-53257-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
	<CAEiveUfGHiz_oXgG9cscOF3ErdH9DJtp5zRxyCW+QbpzpYqc1w@mail.gmail.com>
	<alpine.LRH.2.20.1703131012360.2317@namei.org>
	<02803f61-29e6-97ea-7ed2-babce48206da@canonical.com>
Message-ID: <alpine.LRH.2.20.1703131659250.3299@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, 12 Mar 2017, John Johansen wrote:

> I floated a patch for apparmor to use the task security field in support
> of this in reply last time Tetsuo posted this up. I can reply with the patch
> again to add it to this thread if you would like.

Sounds good.


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: luto@kernel.org (Andy Lutomirski)
Date: Thu, 9 Nov 2017 18:38:34 -0800
Subject: [PATCH RFC v3 6/7] proc: support new 'pids=all|ptraceable' mount
	option
In-Reply-To: <1510244046-3256-7-git-send-email-tixxdz@gmail.com>
References: <1510244046-3256-1-git-send-email-tixxdz@gmail.com>
	<1510244046-3256-7-git-send-email-tixxdz@gmail.com>
Message-ID: <CALCETrWX=GN4KoxysJwDUhYs-fu3wdJU=pzTTKgQuKwa0O2k8w@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Nov 9, 2017 at 8:14 AM, Djalal Harouni <tixxdz@gmail.com> wrote:
> This patch introduces the new 'pids' mount option, as it was discussed
> and suggested by Andy Lutomirski [1].
>
> * If 'pids=' is passed without 'newinstance' then it has no effect.

Would it be safer this were an error instead?
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: steve.backup.kemp@gmail.com (Steve Kemp)
Date: Mon, 4 Jun 2018 19:57:23 +0300
Subject: [PATCH] proc: prevent a task from writing on its own /proc/*/mem
In-Reply-To: <CAJHCu1Ky09DWskcD4nVW5u1C5faWMv1A4kcxWzdiap7+G1SPkg@mail.gmail.com>
References: <1527346246-1334-1-git-send-email-s.mesoraca16@gmail.com>
	<CAGXu5j+PHzDwnJxJwMJ=WuhacDn_vJWe9xZx+Kbsh28vxOGRiA@mail.gmail.com>
	<CA+55aFx6DBp+d33_fytOGPWw11xg_L0MdGp1M2e5Obc0N9kMRQ@mail.gmail.com>
	<CAJHCu1Ky09DWskcD4nVW5u1C5faWMv1A4kcxWzdiap7+G1SPkg@mail.gmail.com>
Message-ID: <CABxV-EWN8ag2zk2CDxWyC3+DvuM3ADbf=qGm4uczK8YnOd5JBQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

> A configurable LSM is probably the right way to do this.

I wonder how many out of tree LSM there are?  Looking at the mainline
kernel the only "small" LSM bundled is YAMA, and it seems that most of
the patches proposing new ones eventually die out.

I appreciate that there are probably a lot of "toy" or "local" modules
out there for specific fields, companies, or products, but it does
seem odd that there are so few discussed publicly.

(The last two I remember were S.A.R.A and something relating to
xattr-attributes being used to whitelist execution.)

Steve
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

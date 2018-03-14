From: stefbon@gmail.com (Stef Bon)
Date: Wed, 14 Mar 2018 08:52:01 +0100
Subject: [PATCH v3 4/4] fuse: define the filesystem as untrusted
In-Reply-To: <1520540650-7451-5-git-send-email-zohar@linux.vnet.ibm.com>
References: <1520540650-7451-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1520540650-7451-5-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <CANXojczCU3UC4xsPYzAYqFW3_WR9Z7QO_exd4dB6eyQR2STuUg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

I do not have any comments about the patches but a question.
I completely agree that the files can change without the VFS knowing
about it, but isn't that in general the case with filesystems with a
backend shared with others (network fs's?).

Stef
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

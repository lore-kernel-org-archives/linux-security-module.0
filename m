From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Fri, 15 Sep 2017 11:37:21 -0700
Subject: [PATCH 1/3] vfs: constify path argument to
	kernel_read_file_from_path
In-Reply-To: <1505451494-30228-2-git-send-email-zohar@linux.vnet.ibm.com>
References: <1505451494-30228-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1505451494-30228-2-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <CA+55aFyp3UYtKGGCE+QupSbsL4rvCxnYXAZnRtwNYy4F2VHGog@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Sep 14, 2017 at 9:58 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> This patch constifies the path argument to kernel_read_file_from_path.

I've applied this upstream independently of everything else, because
it's obviously the right thing to do (as the sound_firmware.h part of
the patch shows, never mind the whole "we're just passing the pathname
to filp_open() which takes a const char"  thing).

               lINUS
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

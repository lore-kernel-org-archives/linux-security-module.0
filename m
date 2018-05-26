From: adobriyan@gmail.com (Alexey Dobriyan)
Date: Sat, 26 May 2018 18:48:19 +0300
Subject: [PATCH] proc: prevent a task from writing on its own /proc/*/mem
In-Reply-To: <1527346246-1334-1-git-send-email-s.mesoraca16@gmail.com>
References: <1527346246-1334-1-git-send-email-s.mesoraca16@gmail.com>
Message-ID: <20180526154819.GA14016@avx2>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, May 26, 2018 at 04:50:46PM +0200, Salvatore Mesoraca wrote:
> Prevent a task from opening, in "write" mode, any /proc/*/mem
> file that operates on the task's mm.
> /proc/*/mem is mainly a debugging means and, as such, it shouldn't
> be used by the inspected process itself.
> Current implementation always allow a task to access its own
> /proc/*/mem file.
> A process can use it to overwrite read-only memory, making
> pointless the use of security_file_mprotect() or other ways to
> enforce RO memory.

You can do it in security_ptrace_access_check() or security_file_open()
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: penguin-kernel@I-love.SAKURA.ne.jp (Tetsuo Handa)
Date: Sat, 28 Jul 2018 11:29:57 +0900
Subject: [PATCH 13/38] tomoyo: Implement security hooks for the new mount
	API [ver #10]
In-Reply-To: <153271277078.9458.16912166489973051987.stgit@warthog.procyon.org.uk>
References: <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
	<153271277078.9458.16912166489973051987.stgit@warthog.procyon.org.uk>
Message-ID: <b4be11f6-8235-1ee1-9a01-c09eb9b88404@I-love.SAKURA.ne.jp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 2018/07/28 2:32, David Howells wrote:
> Implement the security hook to check the creation of a new mountpoint for
> Tomoyo.
> 
> As far as I can tell, Tomoyo doesn't make use of the mount data or parse
> any mount options, so I haven't implemented any of the fs_context hooks for
> it.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> cc: tomoyo-dev-en at lists.sourceforge.jp
> cc: linux-security-module at vger.kernel.org

Would you provide examples of each possible combination as a C program?
For example, if one mount point from multiple sources with different
options are possible, please describe such pattern using syscall so that
LSM modules can run it to see whether they are working as expected. 
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

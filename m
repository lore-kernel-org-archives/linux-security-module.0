From: penguin-kernel@i-love.sakura.ne.jp (Tetsuo Handa)
Date: Wed, 11 Jul 2018 08:34:19 +0900
Subject: [PATCH 10/32] tomoyo: Implement security hooks for the new mount
	API [ver #9]
In-Reply-To: <153126255706.14533.4069320423640498264.stgit@warthog.procyon.org.uk>
References: <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk>
	<153126255706.14533.4069320423640498264.stgit@warthog.procyon.org.uk>
Message-ID: <201807102334.w6ANYJCl033608@www262.sakura.ne.jp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

David Howells wrote:
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
> 

Would you provide examples of each possible combination as a C program?
For example, if one mount point from multiple sources with different
options are possible, please describe such pattern using syscall so that
LSM modules can run it to see whether they are working as expected.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

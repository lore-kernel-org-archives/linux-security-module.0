From: casey@schaufler-ca.com (Casey Schaufler)
Date: Wed, 1 Aug 2018 14:49:41 -0700
Subject: LSM hook for mount, superblock and keys watch notifications
In-Reply-To: <7561.1533157444@warthog.procyon.org.uk>
References: <675e5c24-36ef-4cc5-846c-1414c1195d85@schaufler-ca.com>
	<153235954191.32640.5792167066538704794.stgit@warthog.procyon.org.uk>
	<7561.1533157444@warthog.procyon.org.uk>
Message-ID: <83894922-c126-3648-d2f5-191256111718@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 8/1/2018 2:04 PM, David Howells wrote:
> How about if I apply the attached patch?  It creates a new LSM hook that gets
> called each time a notification is about to be posted on a queue.  It is given
> the creds from the /dev/watch_queue opener, the creds of whoever triggered the
> watchpoint and a pointer to the notification message.
>
> The notification message includes metadata describing the source/type of the
> message and the subtype within that, plus subtype-specific flags.

This looks like it will solve the problem for security modules.
I still think there should be some sort of default controls.
The idea that the default is that anyone can listen for everyone's
events, and there's no way to control it does not sit well.
You could implement that as a security module with the one hook
that does UID based controls, but I don't see a lot of advantages
to doing it that way. At the least a process should be able to hide
the events it would generate from everyone. Better would be to have
a specification (e.g. mod bits, an ACL) for who should receive them.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

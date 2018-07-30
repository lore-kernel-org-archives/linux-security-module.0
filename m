From: dhowells@redhat.com (David Howells)
Date: Mon, 30 Jul 2018 11:49:16 +0100
Subject: [PATCH 13/38] tomoyo: Implement security hooks for the new mount
	API [ver #10]
In-Reply-To: <b4be11f6-8235-1ee1-9a01-c09eb9b88404@I-love.SAKURA.ne.jp>
References: <b4be11f6-8235-1ee1-9a01-c09eb9b88404@I-love.SAKURA.ne.jp>
	<153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
	<153271277078.9458.16912166489973051987.stgit@warthog.procyon.org.uk>
Message-ID: <10224.1532947756@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:

> Would you provide examples of each possible combination as a C program?
> For example, if one mount point from multiple sources with different
> options are possible, please describe such pattern using syscall so that
> LSM modules can run it to see whether they are working as expected. 

One example could be overlayfs.  So you might do, say:

	ufd = open("/overlay", O_PATH);
	fsfd = fsopen("overlay", 0);
	fsconfig(fsfd, fsconfig_set_path, "lowerdir", "/src", AT_FDCWD);
	fsconfig(fsfd, fsconfig_set_path, "upperdir", "upper", ufd);
	fsconfig(fsfd, fsconfig_set_path, "workdir", "scratch", ufd);
	mfd = fsmount(fsfd, 0, 0);
	move_mount(fsfd, "", AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);

which would allow you to specify the "sources" using dirfds.

Another possibility is could be ext4 with separate journal:

	fsfd = fsopen("ext4", 0);
	fsconfig(fsfd, fsconfig_set_path, "source", "/dev/sda1", AT_FDCWD);
	fsconfig(fsfd, fsconfig_set_path, "journal_path", "/dev/sda2", AT_FDCWD);
	mfd = fsmount(fsfd, 0, 0);
	move_mount(fsfd, "", AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);

And then there's bcachefs which suggests on the webpage:

	mount -t bcachefs /dev/sda1:/dev/sdb1 /mnt

but you could then do:

	fsfd = fsopen("bcachefs", 0);
	fsconfig(fsfd, fsconfig_set_path, "source", "/dev/sda1", AT_FDCWD);
	fsconfig(fsfd, fsconfig_set_path, "source", "/dev/sdb2", AT_FDCWD);
	mfd = fsmount(fsfd, 0, 0);
	move_mount(fsfd, "", AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);

One thing I'm not certain of is whether I should allow multiple values to the
same key name, or whether I should require that each key be labelled
differently, possibly something like:

	fsconfig(fsfd, fsconfig_set_path, "source", "/dev/sda1", AT_FDCWD);
	fsconfig(fsfd, fsconfig_set_path, "source.1", "/dev/sdb2", AT_FDCWD);

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

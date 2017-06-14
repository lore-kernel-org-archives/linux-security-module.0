From: dhowells@redhat.com (David Howells)
Date: Wed, 14 Jun 2017 21:42:09 +0100
Subject: [PATCH 08/27] VFS: Introduce the structs and doc for a filesystem
	context [ver #5]
In-Reply-To: <22bc3062-e860-5266-7a2d-9f5eff8b8559@schaufler-ca.com>
References: <22bc3062-e860-5266-7a2d-9f5eff8b8559@schaufler-ca.com>
	<149745330648.10897.9605870130502083184.stgit@warthog.procyon.org.uk>
	<149745339478.10897.13154531822843514976.stgit@warthog.procyon.org.uk>
Message-ID: <1402.1497472929@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Casey Schaufler <casey@schaufler-ca.com> wrote:

> Could you namespace the fields of this structure?
> e.g. fs_cred, fs_security

Linus objects to that practice.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

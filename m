From: dhowells@redhat.com (David Howells)
Date: Sat, 17 Jun 2017 15:18:09 +0100
Subject: [PATCH 08/27] VFS: Introduce the structs and doc for a filesystem
	context [ver #5]
In-Reply-To: <20170617095755.z623wmwgwcw76wce@thunk.org>
References: <20170617095755.z623wmwgwcw76wce@thunk.org>
	<22bc3062-e860-5266-7a2d-9f5eff8b8559@schaufler-ca.com>
	<149745330648.10897.9605870130502083184.stgit@warthog.procyon.org.uk>
	<149745339478.10897.13154531822843514976.stgit@warthog.procyon.org.uk>
	<1402.1497472929@warthog.procyon.org.uk>
	<77078d8b-e8dc-5cd2-2f09-1e796d8e0e2c@schaufler-ca.com>
Message-ID: <9029.1497709089@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Theodore Ts'o <tytso@mit.edu> wrote:

> I don't know that this is a hard and fast rule.  Struct bio uses a
> "bi_" prefix (e.g., bi_error, bi_opf, bi_iter, etc.).

Linus told me to stop doing it.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: tytso@mit.edu (Theodore Ts'o)
Date: Sat, 17 Jun 2017 05:57:55 -0400
Subject: [PATCH 08/27] VFS: Introduce the structs and doc for a
	filesystem context [ver #5]
In-Reply-To: <77078d8b-e8dc-5cd2-2f09-1e796d8e0e2c@schaufler-ca.com>
References: <22bc3062-e860-5266-7a2d-9f5eff8b8559@schaufler-ca.com>
	<149745330648.10897.9605870130502083184.stgit@warthog.procyon.org.uk>
	<149745339478.10897.13154531822843514976.stgit@warthog.procyon.org.uk>
	<1402.1497472929@warthog.procyon.org.uk>
	<77078d8b-e8dc-5cd2-2f09-1e796d8e0e2c@schaufler-ca.com>
Message-ID: <20170617095755.z623wmwgwcw76wce@thunk.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Jun 14, 2017 at 01:53:09PM -0700, Casey Schaufler wrote:
> On 6/14/2017 1:42 PM, David Howells wrote:
> > Casey Schaufler <casey@schaufler-ca.com> wrote:
> >
> >> Could you namespace the fields of this structure?
> >> e.g. fs_cred, fs_security
> > Linus objects to that practice.
> 
> Sigh. Never mind. Thank you.

I don't know that this is a hard and fast rule.  Struct bio uses a
"bi_" prefix (e.g., bi_error, bi_opf, bi_iter, etc.).

I find it's really helpful when I'm doing a "git grep" over the whole
tree; "git grep bi_flags" returns a much more specific and focused
results than "git grep flags".   :-)

						- Ted
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

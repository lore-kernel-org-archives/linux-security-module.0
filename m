From: dhowells@redhat.com (David Howells)
Date: Fri, 26 May 2017 13:43:12 +0100
Subject: [PATCH 3/5] Add the ability to lock down access to the running
	kernel image
In-Reply-To: <fa6647c3-baff-d9e9-8ffe-89042b2a553d@schaufler-ca.com>
References: <fa6647c3-baff-d9e9-8ffe-89042b2a553d@schaufler-ca.com>
	<80bdc6c9-004b-800f-ffd0-4b5ebf8cdeba@schaufler-ca.com>
	<149563711758.9419.11406612723056598045.stgit@warthog.procyon.org.uk>
	<149563714531.9419.16811189348445249219.stgit@warthog.procyon.org.uk>
	<19783.1495695202@warthog.procyon.org.uk>
Message-ID: <22659.1495802592@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Casey Schaufler <casey@schaufler-ca.com> wrote:

> You called out five distinct features in 0/5, so how about
> a bit for each of those?

Actually, there are more than five in that list - there are three in the first
item - and I'm not sure the remaining categories are quite as well defined as
I made it seem.

Also, that sort of categorisation might not be what we actually need: it might
end up coming down to a no-write vs no-read-or-write split instead.

> Actually, I don't care which way you go. The current code works
> for me. I am just concerned that the granularity fiends might come
> around later.

In that case, I'll leave it as is for the moment.  It doesn't introduce so
many calls that they're impossible to change.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

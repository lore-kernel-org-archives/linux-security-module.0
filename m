From: dhowells@redhat.com (David Howells)
Date: Tue, 09 May 2017 08:24:18 +0100
Subject: [PATCH] key: Convert big_key payload.data to struct
In-Reply-To: <20170508221943.GA46762@gmail.com>
References: <20170508221943.GA46762@gmail.com> <20170508214324.GA124468@beast>
	<10235.1494280856@warthog.procyon.org.uk>
Message-ID: <13867.1494314658@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Eric Biggers <ebiggers3@gmail.com> wrote:

> It probably would be easier to kmalloc() this struct and store a pointer to
> it in key->payload.data[0]

Yeah, but it's a waste of resources if you don't have to do it.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: dhowells@redhat.com (David Howells)
Date: Fri, 21 Apr 2017 14:57:17 +0100
Subject: [PATCH 2/5] KEYS: user_defined: sanitize key payloads
In-Reply-To: <20170421083037.12746-3-ebiggers3@gmail.com>
References: <20170421083037.12746-3-ebiggers3@gmail.com>
	<20170421083037.12746-1-ebiggers3@gmail.com>
Message-ID: <20091.1492783037@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Eric Biggers <ebiggers3@gmail.com> wrote:

> -		kfree_rcu(zap, rcu);
> +		call_rcu(&zap->rcu, user_free_payload_rcu);

Add kzfree_rcu()?

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

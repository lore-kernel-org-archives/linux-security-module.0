From: dhowells@redhat.com (David Howells)
Date: Fri, 21 Apr 2017 15:31:08 +0100
Subject: [PATCH 3/5] KEYS: encrypted: sanitize all key material
In-Reply-To: <20170421083037.12746-4-ebiggers3@gmail.com>
References: <20170421083037.12746-4-ebiggers3@gmail.com>
	<20170421083037.12746-1-ebiggers3@gmail.com>
Message-ID: <28373.1492785068@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Eric Biggers <ebiggers3@gmail.com> wrote:

> -	memzero_explicit(epayload->decrypted_data, epayload->decrypted_datalen);
> -	kfree(key->payload.data[0]);
> +	kzfree(key->payload.data[0]);

Should kzfree() be using memzero_explicit() rather than memset()?

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

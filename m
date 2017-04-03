From: dhowells@redhat.com (David Howells)
Date: Mon, 03 Apr 2017 16:48:54 +0100
Subject: [PATCH] KEYS: fix freeing uninitialized memory in key_update()
In-Reply-To: <20170401223645.29528-1-ebiggers3@gmail.com>
References: <20170401223645.29528-1-ebiggers3@gmail.com>
Message-ID: <3742.1491234534@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Pulled.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

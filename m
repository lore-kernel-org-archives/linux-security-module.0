From: dhowells@redhat.com (David Howells)
Date: Mon, 25 Sep 2017 16:28:10 +0100
Subject: [PATCH] KEYS: key refcounting cleanup in keyctl_read_key
In-Reply-To: <065a1f03-a342-c47c-ea6f-b4cc84f869bb@virtuozzo.com>
References: <065a1f03-a342-c47c-ea6f-b4cc84f869bb@virtuozzo.com>
Message-ID: <1319.1506353290@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

I have a patch from Eric Biggers that does the same thing that I've applied.

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?h=keys-fixes&id=7fc0786d956d9e59b68d282be9b156179846ea3d

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

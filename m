From: dhowells@redhat.com (David Howells)
Date: Tue, 11 Sep 2018 23:56:55 +0100
Subject: [RFC 04/12] x86/mm: Add helper functions to manage memory
	encryption keys
In-Reply-To: <28a55df5da1ecfea28bac588d3ac429cf1419b42.1536356108.git.alison.schofield@intel.com>
References: <28a55df5da1ecfea28bac588d3ac429cf1419b42.1536356108.git.alison.schofield@intel.com>
	<cover.1536356108.git.alison.schofield@intel.com>
Message-ID: <30751.1536706615@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Alison Schofield <alison.schofield@intel.com> wrote:

> +void mktme_map_set_keyid(int keyid, unsigned int serial)
> +{
> +	mktme_map->serial[keyid] = serial;
> +	mktme_map->mapped_keyids++;
> +}

It appears that 'serial' should be key_serial_t.

Note that you *aren't* allowed to cache key serial numbers inside the kernel.
You must cache the struct key * instead and hold a reference to the key.  This
will prevent the key from being destroyed whilst it is in use.

David

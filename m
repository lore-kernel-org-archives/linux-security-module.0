From: dhowells@redhat.com (David Howells)
Date: Wed, 12 Sep 2018 00:01:51 +0100
Subject: [RFC 11/12] keys/mktme: Add a new key service type for memory
	encryption keys
In-Reply-To: <20180911223933.GA2638@alison-desk.jf.intel.com>
References: <20180911223933.GA2638@alison-desk.jf.intel.com>
	<1a14a6feb02f968c5e6b98360f6f16106b633b58.1536356108.git.alison.schofield@intel.com>
	<cover.1536356108.git.alison.schofield@intel.com>
	<27768.1536703395@warthog.procyon.org.uk>
Message-ID: <31294.1536706911@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Alison Schofield <alison.schofield@intel.com> wrote:

> If a preparse routine handles all the above, then if any of the
> above failures occur, the key service has less backing out to do.
> Is that the point?

Yes.  Ideally, ->instantiate() would never fail.

> How do I make the connection between the preparse and the instantiate? 
> Do I just put what I need to remember about this key request in the
> payload.data during preparse, so I can examine it again during
> instantiate?

Have a look at user_preparse().  It attaches the contribution to the supplied
key_preparsed_payload struct, which is then passed to ->instantiate() and
->update() as appropriate.  generic_key_instantiate() is used by the user key
type.

David

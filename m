From: dhowells@redhat.com (David Howells)
Date: Thu, 16 Aug 2018 14:15:19 +0100
Subject: [PATCH 1/2] Replace magic for trusting the secondary keyring with
	#define
In-Reply-To: <153442471049.17751.3835342719465644394.stgit@warthog.procyon.org.uk>
References: <153442471049.17751.3835342719465644394.stgit@warthog.procyon.org.uk>
Message-ID: <18610.1534425319@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Yannik,

I would suggest something like that.  I've switched the patches over as has
been suggested.  I think it makes more sense to create the constant first and
then use that.

I've also fleshed out the patch description a bit and added cc and Fixes
fields as appropriate.

David

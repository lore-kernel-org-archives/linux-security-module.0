From: tytso@mit.edu (Theodore Ts'o)
Date: Fri, 14 Jul 2017 15:29:09 -0400
Subject: [PATCH v2] xattr: Enable security.capability in user namespaces
In-Reply-To: <1500058090.3583.28.camel@linux.vnet.ibm.com>
References: <87k23cb6os.fsf@xmission.com>
	<847ccb2a-30c0-a94c-df6f-091c8901eaa0@linux.vnet.ibm.com>
	<87bmoo8bxb.fsf@xmission.com>
	<9a3010e5-ca2b-5e7a-656b-fcc14f7bec4e@linux.vnet.ibm.com>
	<87h8yf7szd.fsf@xmission.com>
	<65dbe654-0d99-03fa-c838-5a726b462826@linux.vnet.ibm.com>
	<20170714133437.GA16737@mail.hallyn.com>
	<596f808b-e21d-8296-5fef-23c1ce7ab778@linux.vnet.ibm.com>
	<20170714173556.GA19669@mail.hallyn.com>
	<1500058090.3583.28.camel@linux.vnet.ibm.com>
Message-ID: <20170714192909.zoxnlm32nrxguqao@thunk.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Jul 14, 2017 at 02:48:10PM -0400, Mimi Zohar wrote:
> 
> If I'm understanding the discussion correctly, this isn't an issue for
> layered copy on write filesystems, as each fs layer could have it's
> own set of xattrs. ?The underlying and layered xattrs should be able
> to co-exist. ?Use the layered xattr if it exists, but fall back to
> using the underlying xattr if it doesn't.

Note that this assumes that it is possible to "copy up" the xattrs
without necessarily "copying up" all of the data blocks.  This might
be true for some layers, but I don't believe it is currently true for
overlayfs, for example.

					- Ted
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

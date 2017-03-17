From: mathew.j.martineau@linux.intel.com (Mat Martineau)
Date: Fri, 17 Mar 2017 15:35:03 -0700 (PDT)
Subject: [PATCH v12 06/10] KEYS: Consistent ordering for __key_link_begin
	and restrict check
In-Reply-To: <19834.1489736603@warthog.procyon.org.uk>
References: <alpine.OSX.2.20.1703161654010.36452@suhwanki-mobl.amr.corp.intel.com>
	<20170309202315.15361-7-mathew.j.martineau@linux.intel.com>
	<20170309202315.15361-1-mathew.j.martineau@linux.intel.com>
	<23615.1489659445@warthog.procyon.org.uk>
	<19834.1489736603@warthog.procyon.org.uk>
Message-ID: <alpine.OSX.2.20.1703171149440.51649@mjmartin-mac01.sea.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org


On Fri, 17 Mar 2017, David Howells wrote:

> Mat Martineau <mathew.j.martineau@linux.intel.com> wrote:
>
>>> Btw, do you check for cycles anywhere?  For example, if I create two keyrings,
>>> A and B, and can I then set restrictions such that A is restricted by B and B
>>> is restricted by A?
>>
>> I don't check for cycles yet, but the references held by the restrictions
>> could be a problem. I'm not sure how to address it yet, I could clear the
>> restriction info when a keyring is revoked/dead/etc or I could check when
>> restrictions are created.
>
> Yep.
>
> The way to do it is to store the pointer to the restriction keyring in the
> restriction record and then when you set a restriction on keyring A that
> refers to keyring B as a source of authority, you go to B's restriction record
> and if it points to A, say no, if it points to C, go to C's record and if it
> points to A, say no, if it points to D, go to D's record and so on and so on -
> all whilst under a master lock.
>
> As the above algorithm only has one pointer to follow each time, it can be
> done iteratively, so no particular stack overhead.  And as a lock is held
> whilst you do the check and the add, you can't get one process adding an A->B
> dependency whilst another adds B->A.


v6 and earlier of the patch set had a pointer to the restriction keyring 
in the restriction record, then we generalized the structure to use a 
void* and the free_data function. The void* is helpful for letting the key 
types have more complicated restrictions (maybe even having *multiple* 
keyring dependencies), but it rules out the iterative search technique.

I see why my first suggestion doesn't work: while destroyed keyrings 
already clear out their restriction references, that doesn't help when the 
ref count goes to 0 on an instantiated keyring.


Do we go back to the simpler restriction record (just a key pointer, no 
void*, no free_data) so we can detect cycles without the stack overhead of 
a depth-first search, like this?

struct key_restriction {
 	key_restrict_link_func_t check;
 	struct key *key;
 	struct key_type *owner_type;
};

If we have both a key pointer and a void*, the void* won't be used by the 
asymmetric key type and future restriction implementations could end up 
with cycle problems if they stash key pointers behind that void*.

Other solutions I can think of would add a lot of complexity (like adding 
weak references), so I favor using the single key pointer as in the struct 
above.

--
Mat Martineau
Intel OTC
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

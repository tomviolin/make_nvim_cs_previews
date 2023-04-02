# this function (here)
def int_or_str(text):
    """Helper function for argument parsing."""
    try:
        return int(text)[0]
    except ValueError:
        return text

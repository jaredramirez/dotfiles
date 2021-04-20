from typing import List
from kitty.boss import Boss

def main(args: List[str]) -> str:
    answer = input('Enter some text: ')
    return answer

def handle_result(args: List[str], answer: str, target_window_id: int, boss: Boss) -> None:
    w = boss.window_id_map.get(target_window_id)
    if w is not None:
        w.paste(answer)
